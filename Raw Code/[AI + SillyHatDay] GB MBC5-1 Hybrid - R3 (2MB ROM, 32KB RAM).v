module MBC5_CPLD_Mapper (
    reset,
    inputAddress,
    inputData,
    inputCE,
    inputWR,
    inputRD,
    highAddress,
    ramCE
);

// ============================================================
// Port Declarations
// ============================================================
input           reset;												// Reset from cart edge
input   [3:0]   inputAddress;   									// A15-A12 from cart edge
input   [6:0]   inputData;      									// D6-D0 from cart edge (only 7 bits needed)
input           inputCE;											// Chip select from cart edge (active low)
input           inputWR;											// Write from cart edge (active low)
input           inputRD;											// Read from cart edge (active low)

output  [7:0]   highAddress;    									// Address outputs A20-A13
output          ramCE;												// Gated chip select output

// ============================================================
// Internal Registers
// ============================================================
reg [7:0]   highAddress;											// Storage for address outputs A20-A13
reg [6:0]   romBank;												// Storage for selected ROM bank
reg [1:0]   ramBank;												// Storage for selected RAM bank
reg         ramEnabled;												// Are RAM read/writes enabled?
reg         mbc1Detect303FOn;
reg         mbc1Detected607F;										// 
reg         mbc3or5Locked;											// Has MBC detection been decided?

// ============================================================
// Convenience wires - reusable logic blocks. Output routed to other blocks reading it.
// ============================================================
wire busActive  = (!inputRD || !inputWR);   						// Is a read or write happening? Gate address output
wire isWrite    = (!inputWR && inputRD && inputCE); 				// Is a clean write happening? Bank register write
wire isRamArea  = (inputAddress == 4'hA || inputAddress == 4'hB);	// Is address in 0xA000-BFFF window?
wire isRomLow   = (inputAddress <= 4'd3);   						// Looking at low 16KB ROM 0x0000-3FFF?
wire isRomHigh  = (inputAddress >= 4'd4 && inputAddress <= 4'd7); 	// Looking at high 16KB ROM 0x4000-7FFF?

// ============================================================
// ramCE — purely combinatorial, separate block
// ============================================================
reg ramCE;

always @ (*) begin													// Monitor everything in this block
    if (ramEnabled && isRamArea && busActive) begin					// Is RAM enabled, address in range & bus clear?
        ramCE = inputCE;											// If check passed, passthrough signal
    end
    else begin
        ramCE = 1'b1; 												// Drive high for off, active low
    end
end

// ============================================================
// highAddress — combinatorial, depends on address + bank regs
// ============================================================
always @ (*) begin													// Monitor everything in this block
    if (isRamArea && ramEnabled && busActive) begin					// Is RAM being accessed?
        highAddress = {6'b0, ramBank};								// Change address pins to current RAM bank value saved
    end
    else if (busActive && isRomLow) begin							// Is lower 16KB ROM being accessed?
        highAddress = 8'b0;											// Map lower 16KB bank address (turn off high address lines)
    end
    else if (busActive && isRomHigh) begin							// Is upper 16KB ROM being accessed?
        highAddress = (romBank << 1);								// Map upper 16KB banks address (bit shift to fit 7 bits into 8 correctly)
    end																// AKA align A14 with A14, else A14 would line up with A13
    else begin
        highAddress = 8'b0;											// If all else fails, just map 16KB lower bank
    end
end

// ============================================================
// Registered state — resets and bank register writes
// Triggered on control signals + address + data
// ============================================================
always @ (*) begin													// Try negedge here instead of being transparent

    if (!reset) begin
        romBank             <= 7'd1;								// Inferred latches are OK
        ramBank             <= 2'd0;								// All these updated at once when out of reset
        ramEnabled          <= 1'b0;								// <= inside transparent block is weird
        mbc1Detect303FOn    <= 1'b0;
        mbc1Detected607F    <= 1'b0;
        mbc3or5Locked       <= 1'b0;
    end
    else begin

        if ((inputAddress == 4'd0 || inputAddress == 4'd1) && isWrite) begin	// 0x0000-1FFF — RAM Enable
            ramEnabled <= (inputData[3:0] == 4'hA) ? 1'b1 : 1'b0;				// Write 0x?A to enable, anything else disables
        end

        if ((inputAddress == 4'd2 ||
            (inputAddress == 4'd3 && mbc1Detect303FOn)) && isWrite) begin		// 0x2000-3FFF — ROM Bank Number low 7 bits
            if (inputData == 7'd0) begin										// MBC1 detection: if data=0 written, note it
                romBank          <= 7'd1; 										// MBC5 allows bank 0, keep as 1 for safety
                mbc1Detect303FOn <= 1'b1;										// MBC1 detection noted
            end
            else begin
                if (inputData >= 7'd32) begin									// Is data greater or equal to decimal 32
                    mbc3or5Locked <= 1'b1;										// If so, set lock bit
                end
                romBank <= inputData;											// ROM bank equals data
            end
        end

        if ((inputAddress == 4'd4 || inputAddress == 4'd5) && isWrite) begin		// 0x4000-5FFF — RAM Bank Number
            if (!(mbc1Detect303FOn && mbc1Detected607F && !mbc3or5Locked)) begin	// Ignored if MBC1 detected and not MBC3/5
                ramBank <= inputData[1:0];											// RAM banking set to lower 2 bits of data
            end
        end

        if ((inputAddress == 4'd6 || inputAddress == 4'd7) && isWrite) begin	 // 0x6000-7FFF — MBC1 ROM/RAM mode detection
            mbc1Detected607F <= 1'b1;											 // MBC1 detected, set register bit
        end

    end
end

endmodule

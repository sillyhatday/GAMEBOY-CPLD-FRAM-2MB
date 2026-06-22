module MBC5_CPLD_Claude (
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
input           reset;
input   [3:0]   inputAddress;   // a15-a12
input   [6:0]   inputData;      // d6-d0
input           inputCE;
input           inputWR;
input           inputRD;

output  [7:0]   highAddress;    // a20-a13
output          ramCE;

// ============================================================
// Internal Registers
// ============================================================
reg [7:0]   highAddress;
reg [6:0]   romBank;
reg [1:0]   ramBank;
reg         ramEnabled;
reg         mbc1Detect303FOn;
reg         mbc1Detected607F;
reg         mbc3or5Locked;

// ============================================================
// Convenience wires
// ============================================================
wire busActive  = (!inputRD || !inputWR);   // any bus activity
wire isWrite    = (!inputWR && inputRD && inputCE); // clean write strobe
wire isRamArea  = (inputAddress == 4'hA || inputAddress == 4'hB);
wire isRomLow   = (inputAddress <= 4'd3);   // 0x0000-3FFF
wire isRomHigh  = (inputAddress >= 4'd4 && inputAddress <= 4'd7); // 0x4000-7FFF

// ============================================================
// ramCE — purely combinatorial, separate block
// Keeps CE clean regardless of clock signal behaviour
// ============================================================
reg ramCE;

always @ (*) begin
    if (ramEnabled && isRamArea && busActive) begin
        ramCE = inputCE;
    end
    else begin
        ramCE = 1'b1; // deasserted (active low, so high = disabled)
    end
end

// ============================================================
// highAddress — combinatorial, depends on address + bank regs
// ============================================================
always @ (*) begin
    if (isRamArea && ramEnabled && busActive) begin
        // RAM access: output ram bank on lower address bits
        highAddress = {6'b0, ramBank};
    end
    else if (busActive && isRomLow) begin
        // ROM bank 0 window: always physical bank 0
        highAddress = 8'b0;
    end
    else if (busActive && isRomHigh) begin
        // ROM bank 1+ window: shift romBank up to a14
        highAddress = (romBank << 1);
    end
    else begin
        highAddress = 8'b0;
    end
end

// ============================================================
// Registered state — resets and bank register writes
// Triggered on control signals + address + data
// ============================================================
always @ (*) begin

    if (!reset) begin
        romBank             <= 7'd1;
        ramBank             <= 2'd0;
        ramEnabled          <= 1'b0;
        mbc1Detect303FOn    <= 1'b0;
        mbc1Detected607F    <= 1'b0;
        mbc3or5Locked       <= 1'b0;
    end
    else begin

        // --------------------------------------------------------
        // 0x0000-1FFF — RAM Enable register
        // Write 0x?A to enable, anything else disables
        // --------------------------------------------------------
        if ((inputAddress == 4'd0 || inputAddress == 4'd1) && isWrite) begin
            ramEnabled <= (inputData[3:0] == 4'hA) ? 1'b1 : 1'b0;
        end

        // --------------------------------------------------------
        // 0x2000-3FFF — ROM Bank Number low 7 bits
        // MBC1 detection: if data=0 written here, note it
        // --------------------------------------------------------
        if ((inputAddress == 4'd2 ||
            (inputAddress == 4'd3 && mbc1Detect303FOn)) && isWrite) begin
            if (inputData == 7'd0) begin
                romBank          <= 7'd1; // MBC5 allows bank 0, keep as 1 for safety
                mbc1Detect303FOn <= 1'b1;
            end
            else begin
                if (inputData >= 7'd32) begin
                    mbc3or5Locked <= 1'b1;
                end
                romBank <= inputData;
            end
        end

        // --------------------------------------------------------
        // 0x4000-5FFF — RAM Bank Number
        // Ignored if MBC1 detected and not MBC3/5
        // --------------------------------------------------------
        if ((inputAddress == 4'd4 || inputAddress == 4'd5) && isWrite) begin
            if (!(mbc1Detect303FOn && mbc1Detected607F && !mbc3or5Locked)) begin
                ramBank <= inputData[1:0];
            end
        end

        // --------------------------------------------------------
        // 0x6000-7FFF — MBC1 ROM/RAM mode detection
        // --------------------------------------------------------
        if ((inputAddress == 4'd6 || inputAddress == 4'd7) && isWrite) begin
            mbc1Detected607F <= 1'b1;
        end

    end
end

endmodule
module part2 (
    clear,
    clock,
    digit,
    digit_valid,
    end_of_line,
    total,
    line_result
);

    input clear;
    input clock;
    input [3:0] digit;
    input digit_valid;
    input end_of_line;
    output [63:0] total;
    output [47:0] line_result;

    wire [63:0] _205;
    wire [47:0] _38;
    wire [43:0] _196;
    wire [47:0] _197;
    wire [47:0] _193;
    wire [47:0] _186;
    wire [47:0] _172;
    wire [47:0] _158;
    wire [47:0] _144;
    wire [47:0] _130;
    wire [47:0] _116;
    wire [47:0] _102;
    wire [47:0] _88;
    wire [47:0] _74;
    wire [47:0] _60;
    wire vdd;
    wire _3;
    wire _5;
    wire [47:0] _49;
    wire [3:0] _7;
    wire [47:0] _45;
    wire _46;
    wire _47;
    wire [47:0] _50;
    wire [47:0] _52;
    wire [47:0] _8;
    reg [47:0] _43;
    wire [47:0] _9;
    wire [95:0] _57;
    wire [47:0] _58;
    wire [47:0] _61;
    wire _62;
    wire _63;
    wire [47:0] _64;
    wire [47:0] _66;
    wire [47:0] _10;
    reg [47:0] _55;
    wire [47:0] _11;
    wire [95:0] _71;
    wire [47:0] _72;
    wire [47:0] _75;
    wire _76;
    wire _77;
    wire [47:0] _78;
    wire [47:0] _80;
    wire [47:0] _12;
    reg [47:0] _69;
    wire [47:0] _13;
    wire [95:0] _85;
    wire [47:0] _86;
    wire [47:0] _89;
    wire _90;
    wire _91;
    wire [47:0] _92;
    wire [47:0] _94;
    wire [47:0] _14;
    reg [47:0] _83;
    wire [47:0] _15;
    wire [95:0] _99;
    wire [47:0] _100;
    wire [47:0] _103;
    wire _104;
    wire _105;
    wire [47:0] _106;
    wire [47:0] _108;
    wire [47:0] _16;
    reg [47:0] _97;
    wire [47:0] _17;
    wire [95:0] _113;
    wire [47:0] _114;
    wire [47:0] _117;
    wire _118;
    wire _119;
    wire [47:0] _120;
    wire [47:0] _122;
    wire [47:0] _18;
    reg [47:0] _111;
    wire [47:0] _19;
    wire [95:0] _127;
    wire [47:0] _128;
    wire [47:0] _131;
    wire _132;
    wire _133;
    wire [47:0] _134;
    wire [47:0] _136;
    wire [47:0] _20;
    reg [47:0] _125;
    wire [47:0] _21;
    wire [95:0] _141;
    wire [47:0] _142;
    wire [47:0] _145;
    wire _146;
    wire _147;
    wire [47:0] _148;
    wire [47:0] _150;
    wire [47:0] _22;
    reg [47:0] _139;
    wire [47:0] _23;
    wire [95:0] _155;
    wire [47:0] _156;
    wire [47:0] _159;
    wire _160;
    wire _161;
    wire [47:0] _162;
    wire [47:0] _164;
    wire [47:0] _24;
    reg [47:0] _153;
    wire [47:0] _25;
    wire [95:0] _169;
    wire [47:0] _170;
    wire [47:0] _173;
    wire _174;
    wire _175;
    wire [47:0] _176;
    wire [47:0] _178;
    wire [47:0] _26;
    reg [47:0] _167;
    wire [47:0] _27;
    wire [95:0] _183;
    wire [47:0] _184;
    wire [47:0] _187;
    wire _188;
    wire _189;
    wire [47:0] _190;
    wire [47:0] _192;
    wire [47:0] _28;
    reg [47:0] _181;
    wire [47:0] _29;
    wire [95:0] _194;
    wire [47:0] _195;
    wire [47:0] _198;
    wire _199;
    wire _31;
    wire _200;
    wire [47:0] _201;
    wire _33;
    wire [47:0] _203;
    wire [47:0] _34;
    reg [47:0] _40;
    wire [15:0] _207;
    wire [63:0] _208;
    wire [63:0] _209;
    wire [63:0] _35;
    reg [63:0] _206;
    assign _205 = 64'b0000000000000000000000000000000000000000000000000000000000000000;
    assign _38 = 48'b000000000000000000000000000000000000000000000000;
    assign _196 = 44'b00000000000000000000000000000000000000000000;
    assign _197 = { _196,
                    _7 };
    assign _193 = 48'b000000000000000000000000000000000000000000001010;
    assign _186 = { _196,
                    _7 };
    assign _172 = { _196,
                    _7 };
    assign _158 = { _196,
                    _7 };
    assign _144 = { _196,
                    _7 };
    assign _130 = { _196,
                    _7 };
    assign _116 = { _196,
                    _7 };
    assign _102 = { _196,
                    _7 };
    assign _88 = { _196,
                   _7 };
    assign _74 = { _196,
                   _7 };
    assign _60 = { _196,
                   _7 };
    assign vdd = 1'b1;
    assign _3 = clear;
    assign _5 = clock;
    assign _49 = { _196,
                   _7 };
    assign _7 = digit;
    assign _45 = { _196,
                   _7 };
    assign _46 = _43 < _45;
    assign _47 = _31 & _46;
    assign _50 = _47 ? _49 : _43;
    assign _52 = _33 ? _38 : _50;
    assign _8 = _52;
    always @(posedge _5) begin
        if (_3)
            _43 <= _38;
        else
            _43 <= _8;
    end
    assign _9 = _43;
    assign _57 = _9 * _193;
    assign _58 = _57[47:0];
    assign _61 = _58 + _60;
    assign _62 = _55 < _61;
    assign _63 = _31 & _62;
    assign _64 = _63 ? _61 : _55;
    assign _66 = _33 ? _38 : _64;
    assign _10 = _66;
    always @(posedge _5) begin
        if (_3)
            _55 <= _38;
        else
            _55 <= _10;
    end
    assign _11 = _55;
    assign _71 = _11 * _193;
    assign _72 = _71[47:0];
    assign _75 = _72 + _74;
    assign _76 = _69 < _75;
    assign _77 = _31 & _76;
    assign _78 = _77 ? _75 : _69;
    assign _80 = _33 ? _38 : _78;
    assign _12 = _80;
    always @(posedge _5) begin
        if (_3)
            _69 <= _38;
        else
            _69 <= _12;
    end
    assign _13 = _69;
    assign _85 = _13 * _193;
    assign _86 = _85[47:0];
    assign _89 = _86 + _88;
    assign _90 = _83 < _89;
    assign _91 = _31 & _90;
    assign _92 = _91 ? _89 : _83;
    assign _94 = _33 ? _38 : _92;
    assign _14 = _94;
    always @(posedge _5) begin
        if (_3)
            _83 <= _38;
        else
            _83 <= _14;
    end
    assign _15 = _83;
    assign _99 = _15 * _193;
    assign _100 = _99[47:0];
    assign _103 = _100 + _102;
    assign _104 = _97 < _103;
    assign _105 = _31 & _104;
    assign _106 = _105 ? _103 : _97;
    assign _108 = _33 ? _38 : _106;
    assign _16 = _108;
    always @(posedge _5) begin
        if (_3)
            _97 <= _38;
        else
            _97 <= _16;
    end
    assign _17 = _97;
    assign _113 = _17 * _193;
    assign _114 = _113[47:0];
    assign _117 = _114 + _116;
    assign _118 = _111 < _117;
    assign _119 = _31 & _118;
    assign _120 = _119 ? _117 : _111;
    assign _122 = _33 ? _38 : _120;
    assign _18 = _122;
    always @(posedge _5) begin
        if (_3)
            _111 <= _38;
        else
            _111 <= _18;
    end
    assign _19 = _111;
    assign _127 = _19 * _193;
    assign _128 = _127[47:0];
    assign _131 = _128 + _130;
    assign _132 = _125 < _131;
    assign _133 = _31 & _132;
    assign _134 = _133 ? _131 : _125;
    assign _136 = _33 ? _38 : _134;
    assign _20 = _136;
    always @(posedge _5) begin
        if (_3)
            _125 <= _38;
        else
            _125 <= _20;
    end
    assign _21 = _125;
    assign _141 = _21 * _193;
    assign _142 = _141[47:0];
    assign _145 = _142 + _144;
    assign _146 = _139 < _145;
    assign _147 = _31 & _146;
    assign _148 = _147 ? _145 : _139;
    assign _150 = _33 ? _38 : _148;
    assign _22 = _150;
    always @(posedge _5) begin
        if (_3)
            _139 <= _38;
        else
            _139 <= _22;
    end
    assign _23 = _139;
    assign _155 = _23 * _193;
    assign _156 = _155[47:0];
    assign _159 = _156 + _158;
    assign _160 = _153 < _159;
    assign _161 = _31 & _160;
    assign _162 = _161 ? _159 : _153;
    assign _164 = _33 ? _38 : _162;
    assign _24 = _164;
    always @(posedge _5) begin
        if (_3)
            _153 <= _38;
        else
            _153 <= _24;
    end
    assign _25 = _153;
    assign _169 = _25 * _193;
    assign _170 = _169[47:0];
    assign _173 = _170 + _172;
    assign _174 = _167 < _173;
    assign _175 = _31 & _174;
    assign _176 = _175 ? _173 : _167;
    assign _178 = _33 ? _38 : _176;
    assign _26 = _178;
    always @(posedge _5) begin
        if (_3)
            _167 <= _38;
        else
            _167 <= _26;
    end
    assign _27 = _167;
    assign _183 = _27 * _193;
    assign _184 = _183[47:0];
    assign _187 = _184 + _186;
    assign _188 = _181 < _187;
    assign _189 = _31 & _188;
    assign _190 = _189 ? _187 : _181;
    assign _192 = _33 ? _38 : _190;
    assign _28 = _192;
    always @(posedge _5) begin
        if (_3)
            _181 <= _38;
        else
            _181 <= _28;
    end
    assign _29 = _181;
    assign _194 = _29 * _193;
    assign _195 = _194[47:0];
    assign _198 = _195 + _197;
    assign _199 = _40 < _198;
    assign _31 = digit_valid;
    assign _200 = _31 & _199;
    assign _201 = _200 ? _198 : _40;
    assign _33 = end_of_line;
    assign _203 = _33 ? _38 : _201;
    assign _34 = _203;
    always @(posedge _5) begin
        if (_3)
            _40 <= _38;
        else
            _40 <= _34;
    end
    assign _207 = 16'b0000000000000000;
    assign _208 = { _207,
                    _40 };
    assign _209 = _206 + _208;
    assign _35 = _209;
    always @(posedge _5) begin
        if (_3)
            _206 <= _205;
        else
            if (_33)
                _206 <= _35;
    end
    assign total = _206;
    assign line_result = _40;

endmodule

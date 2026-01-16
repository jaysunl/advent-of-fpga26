module part1 (
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
    output [31:0] total;
    output [7:0] line_result;

    wire [31:0] _42;
    wire [7:0] _17;
    wire [3:0] _33;
    wire [7:0] _34;
    wire [7:0] _30;
    wire vdd;
    wire _3;
    wire _5;
    wire [3:0] _7;
    wire _23;
    wire [3:0] _24;
    wire [3:0] _25;
    wire [3:0] _27;
    wire [3:0] _8;
    reg [3:0] _22;
    wire [7:0] _29;
    wire [15:0] _31;
    wire [7:0] _32;
    wire [7:0] _35;
    wire _36;
    wire _10;
    wire _37;
    wire [7:0] _38;
    wire _12;
    wire [7:0] _40;
    wire [7:0] _13;
    reg [7:0] _19;
    wire [23:0] _44;
    wire [31:0] _45;
    wire [31:0] _46;
    wire [31:0] _14;
    reg [31:0] _43;
    assign _42 = 32'b00000000000000000000000000000000;
    assign _17 = 8'b00000000;
    assign _33 = 4'b0000;
    assign _34 = { _33,
                   _7 };
    assign _30 = 8'b00001010;
    assign vdd = 1'b1;
    assign _3 = clear;
    assign _5 = clock;
    assign _7 = digit;
    assign _23 = _22 < _7;
    assign _24 = _23 ? _7 : _22;
    assign _25 = _10 ? _24 : _22;
    assign _27 = _12 ? _33 : _25;
    assign _8 = _27;
    always @(posedge _5) begin
        if (_3)
            _22 <= _33;
        else
            _22 <= _8;
    end
    assign _29 = { _33,
                   _22 };
    assign _31 = _29 * _30;
    assign _32 = _31[7:0];
    assign _35 = _32 + _34;
    assign _36 = _19 < _35;
    assign _10 = digit_valid;
    assign _37 = _10 & _36;
    assign _38 = _37 ? _35 : _19;
    assign _12 = end_of_line;
    assign _40 = _12 ? _17 : _38;
    assign _13 = _40;
    always @(posedge _5) begin
        if (_3)
            _19 <= _17;
        else
            _19 <= _13;
    end
    assign _44 = 24'b000000000000000000000000;
    assign _45 = { _44,
                   _19 };
    assign _46 = _43 + _45;
    assign _14 = _46;
    always @(posedge _5) begin
        if (_3)
            _43 <= _42;
        else
            if (_12)
                _43 <= _14;
    end
    assign total = _43;
    assign line_result = _19;

endmodule

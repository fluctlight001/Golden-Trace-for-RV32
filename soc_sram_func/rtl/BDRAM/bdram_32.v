module bdram_32 (
input                     clka,
input                     ena,
input   [3:0]             wea,
input   [16:0]            addra,
input   [31:0]            dina,
output  reg[31:0]         douta
);

parameter  MEMDEPTH = 2**(17);

wire [31:0] inst_read;

reg [31:0] mem [(MEMDEPTH-1):0] /* synthesis syn_ramstyle = "no_rw_check" */;

// initial begin
//   $readmemh("E:/develop/frv232platform/tb/riscvtest/fib-riscv32-nemu.bin.data",_frv_bdram_32.mem);
// end

wire[7:0] mem_0 = mem[addra][7:0];
wire[7:0] mem_1 = mem[addra][15:8];
wire[7:0] mem_2 = mem[addra][23:16];
wire[7:0] mem_3 = mem[addra][31:24];


wire[7:0] memw_0 = wea[0] ? dina[7:0]    : mem_0;
wire[7:0] memw_1 = wea[1] ? dina[15:8]   : mem_1;
wire[7:0] memw_2 = wea[2] ? dina[23:16]  : mem_2;
wire[7:0] memw_3 = wea[3] ? dina[31:24]  : mem_3;

wire [31:0] memw_data = {memw_3, memw_2, memw_1, memw_0};

// wire TEST_JUDGE = mem[16'h008b] == 32'h0984_0913;

assign inst_read = mem[addra];

always @(posedge clka)
begin
  if(|wea)
  begin
    if(ena)begin
      mem[addra]       <= memw_data;
    end
    douta            <= dina;
    // douta           <= inst_read;
  end
  else
  begin
    // dout            <= mem[addra];
    douta           <= inst_read;
  end
end

endmodule

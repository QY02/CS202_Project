`timescale 1ns / 1ps

//参考github仓库已有代码
module keyboard(
  input            clk,
  input            rst,
  input      [3:0] row,                 // row selection signal
  output reg [3:0] col,                 // column selection signal
  output reg [15:0] boarddata        // output data
);
 
// 给键盘状态机分频
reg [19:0] cnt;
 
always @ (posedge clk, posedge rst)
  if (rst)
    cnt <= 0;
  else
    cnt <= cnt + 1'b1;
 
wire key_clk = cnt[19];                // (2^20/50M = 21)ms 
 
 
//状态机，状态值
parameter NO_KEY_PRESSED = 6'b000_001;  // 没有按键
parameter SCAN_COL0      = 6'b000_010;  // 扫描列1
parameter SCAN_COL1      = 6'b000_100;  // 扫描列2
parameter SCAN_COL2      = 6'b001_000;  // 扫描列3
parameter SCAN_COL3      = 6'b010_000;  // 扫描列4
parameter KEY_PRESSED    = 6'b100_000;  // 有键按下

reg [5:0] current_state, next_state;    // ��̬����̬
 
always @ (posedge key_clk, posedge rst)
  if (rst)
    current_state <= NO_KEY_PRESSED;
  else
    current_state <= next_state;

// 状态转移
always @ (*)
  case (current_state)    //���а������£�row != 4h'F,��col0��ʼһ��һ��ɨ��
            NO_KEY_PRESSED :                    // û�а�������
                if (row != 4'hF)
                next_state = SCAN_COL0;
                else
                next_state = NO_KEY_PRESSED;
            SCAN_COL0 :                         // ɨ���0�� 
                if (row != 4'hF)
                next_state = KEY_PRESSED;
                else
                next_state = SCAN_COL1;
            SCAN_COL1 :                         // ɨ���1�� 
                if (row != 4'hF)
                next_state = KEY_PRESSED;
                else
                next_state = SCAN_COL2;    
            SCAN_COL2 :                         // ɨ���2��
                if (row != 4'hF)
                next_state = KEY_PRESSED;
                else
                next_state = SCAN_COL3;
            SCAN_COL3 :                         // ɨ���3��
                if (row != 4'hF)
                next_state = KEY_PRESSED;
                else
                next_state = NO_KEY_PRESSED;
            KEY_PRESSED :                       // �а�������
                if (row != 4'hF)
                next_state = KEY_PRESSED;
                else
                next_state = NO_KEY_PRESSED;                      
    endcase
     //next_state�����ɨ��Ľ������next_state����row != 4'hF��ͣ��
 
reg       key_pressed_flag;             // ���̰��±�־
reg [3:0] col_val, row_val;             // ��ֵ����ֵ
 
// ���ݴ�̬������Ӧ�Ĵ�����ֵ
always @ (posedge key_clk, posedge rst)
  if (rst)
  begin
    col              <= 4'h0;
    key_pressed_flag <=    0;
  end
  else
    case (next_state)
      NO_KEY_PRESSED :                  // û�а�������
      begin
        col              <= 4'h0;
        key_pressed_flag <=    0;       // ����̰��±�־
      end
      SCAN_COL0 :                       // ɨ���0��
        col <= 4'b1110;
      SCAN_COL1 :                       // ɨ���1��
        col <= 4'b1101;
      SCAN_COL2 :                       // ɨ���2��
        col <= 4'b1011;
      SCAN_COL3 :                       // ɨ���3��
        col <= 4'b0111;
      KEY_PRESSED :                     // �а�������
      begin
        col_val          <= col;        // ������ֵ
        row_val          <= row;        // ������ֵ
        key_pressed_flag <= 1;          // �ü��̰��±�־  
      end
    endcase
//--------------------------------------
// ״̬������ ����
//--------------------------------------
 
 
//++++++++++++++++++++++++++++++++++++++
// ɨ������ֵ���� ��ʼ
//++++++++++++++++++++++++++++++++++++++
always @ (posedge key_clk, posedge rst)
  if (rst)
    boarddata <= 16'h0;
  else
    if (key_pressed_flag)
        case ({col_val, row_val})
            8'b1110_1110 : boarddata <= 4'h1;  
            8'b1110_1101 : boarddata <= 4'h4;
            8'b1110_1011 : boarddata <= 4'h7;
            8'b1110_0111 : boarddata <= 4'he;
            
            8'b1101_1110 : boarddata <= 4'h2;
            8'b1101_1101 : boarddata <= 4'h5;
            8'b1101_1011 : boarddata <= 4'h8;
            8'b1101_0111 : boarddata <= 4'h0;
            
            8'b1011_1110 : boarddata <= 4'h3;
            8'b1011_1101 : boarddata <= 4'h6;
            8'b1011_1011 : boarddata <= 4'h9;
            8'b1011_0111 : boarddata <= 4'hf;

            8'b0111_1110 : boarddata <= 4'ha;
            8'b0111_1101 : boarddata <= 4'hb;
            8'b0111_1011 : boarddata <= 4'hc;
            8'b0111_0111 : boarddata <= 4'hd;

            // default: boarddata <= boarddata;        
    endcase
endmodule
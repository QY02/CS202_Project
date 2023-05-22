module keyboard( //参考github上已有代码
  input            clk,        //20Mhz
  input            rst,
  input         IORead,
  input   KeyBoardCtrl,
  input      [3:0] row,        // 矩阵键盘 行       
  output reg [3:0] col,        // 矩阵键盘 列       
  output reg [31:0] io_rdata       
);
 
//控制信号IOread & KeyBoardCtrl 控制其输出，作为内存
reg [4:0] boarddata;
always@(negedge clk or negedge rst) begin
    if(~rst) begin
        io_rdata <= 32'b0;
        end
		else begin
            if (KeyBoardCtrl && IORead) begin
                io_rdata[4:0] <= boarddata[4:0];
            end
            else begin
                io_rdata <= io_rdata;
            end
        end
    end

// 分频部分 开始
reg [17:0] cnt;
 
always @ (negedge clk, negedge rst)
  if (~rst)
    cnt <= 0;
  else
    cnt <= cnt + 1'b1;
 
wire key_clk = cnt[17];


// 状态机部分 开始
// 状态数较少，独热码编码
parameter NO_KEY_PRESSED = 6'b000_001;  // 没有按键按下  
parameter SCAN_COL0      = 6'b000_010;  // 扫描第0列 
parameter SCAN_COL1      = 6'b000_100;  // 扫描第1列 
parameter SCAN_COL2      = 6'b001_000;  // 扫描第2列 
parameter SCAN_COL3      = 6'b010_000;  // 扫描第3列 
parameter KEY_PRESSED    = 6'b100_000;  // 有按键按下

reg [5:0] current_state, next_state;    // 现态、次态
 
always @ (negedge key_clk, negedge rst)
  if (~rst)
    current_state <= NO_KEY_PRESSED;
  else
    current_state <= next_state;

// 根据条件转移状态
always @ (*)
  case (current_state)    //若有按键按下，row != 4h'F,从col0开始一列一列扫描
            NO_KEY_PRESSED :                   
                if (row != 4'hF)
                next_state = SCAN_COL0;
                else
                next_state = NO_KEY_PRESSED;
            SCAN_COL0 :                        
                if (row != 4'hF)
                next_state = KEY_PRESSED;
                else
                next_state = SCAN_COL1;
            SCAN_COL1 :                       
                if (row != 4'hF)
                next_state = KEY_PRESSED;
                else
                next_state = SCAN_COL2;    
            SCAN_COL2 :                      
                if (row != 4'hF)
                next_state = KEY_PRESSED;
                else
                next_state = SCAN_COL3;
            SCAN_COL3 :                        
                if (row != 4'hF)
                next_state = KEY_PRESSED;
                else
                next_state = NO_KEY_PRESSED;
            KEY_PRESSED :                       
                if (row != 4'hF)
                next_state = KEY_PRESSED;
                else
                next_state = NO_KEY_PRESSED;                      
    endcase
//next_state是最后扫描的结果（到next_state发现row != 4'hF才停）

reg       key_pressed_flag;            // 键盘按下标志 
reg [3:0] col_val, row_val;           // 列值、行值
 
// 根据次态，给相应寄存器赋值
always @ (negedge key_clk, negedge rst)
  if (~rst)
  begin
    col              <= 4'h0;
    key_pressed_flag <=    0;
  end
  else
    case (next_state)
      NO_KEY_PRESSED :                  // 没有按键按下
      begin
        col              <= 4'h0;
        key_pressed_flag <=    0;       // 清键盘按下标志
      end
      SCAN_COL0 :                       // 扫描第0列
        col <= 4'b1110;
      SCAN_COL1 :                       // 扫描第1列
        col <= 4'b1101;
      SCAN_COL2 :                       // 扫描第2列
        col <= 4'b1011;
      SCAN_COL3 :                       // 扫描第3列
        col <= 4'b0111;
      KEY_PRESSED :                     // 有按键按下
      begin
        col_val          <= col;        // 锁存列值
        row_val          <= row;        // 锁存行值
        key_pressed_flag <= 1;          // 置键盘按下标志  
      end
    endcase
// 状态机部分 结束
 

// 扫描行列值部分 开始
always @ (negedge key_clk, negedge rst)
  if (~rst)
    boarddata <= 5'b1_1111;
  else
    if (key_pressed_flag)
        case ({col_val, row_val})
            8'b1110_1110 : boarddata <= 5'h1;    //从右往左，从下往上扫描键盘
            8'b1110_1101 : boarddata <= 5'h4;
            8'b1110_1011 : boarddata <= 5'h7;
            8'b1110_0111 : boarddata <= 5'hE;
            
            8'b1101_1110 : boarddata <= 5'h2;
            8'b1101_1101 : boarddata <= 5'h5;
            8'b1101_1011 : boarddata <= 5'h8;
            8'b1101_0111 : boarddata <= 5'h0;
            
            8'b1011_1110 : boarddata <= 5'h3;
            8'b1011_1101 : boarddata <= 5'h6;
            8'b1011_1011 : boarddata <= 5'h9;
            8'b1011_0111 : boarddata <= 5'hF;

            8'b0111_1110 : boarddata <= 5'hA;
            8'b0111_1101 : boarddata <= 5'hB;
            8'b0111_1011 : boarddata <= 5'hC;
            8'b0111_0111 : boarddata <= 5'hD;     
        endcase
    else
        boarddata <= 5'b1_1111;
endmodule
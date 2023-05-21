module keyboard(
  input            clk,
  input            rst,
  input         IORead,
  input   KeyBoardCtrl,
  input      [3:0] row,               
  output reg [3:0] col,               
  output reg [31:0] io_rdata       
);
 
reg [3:0] boarddata;
always@(negedge clk or negedge rst) begin
    if(~rst) begin
        io_rdata <= 32'b0;
        end
		else begin
            if (KeyBoardCtrl && IORead) begin
                io_rdata[3:0] <= boarddata[3:0];
            end
            else begin
                io_rdata <= io_rdata;
            end
        end
    end

reg [17:0] cnt;                        
 
always @ (negedge clk, negedge rst)
  if (~rst)
    cnt <= 0;
  else
    cnt <= cnt + 1'b1;
 
wire key_clk = cnt[17];                // (2^20/50M = 21)ms 


parameter NO_KEY_PRESSED = 6'b000_001; 
parameter SCAN_COL0      = 6'b000_010;  
parameter SCAN_COL1      = 6'b000_100;  
parameter SCAN_COL2      = 6'b001_000;  
parameter SCAN_COL3      = 6'b010_000;  
parameter KEY_PRESSED    = 6'b100_000;  

reg [5:0] current_state, next_state;    
 
always @ (negedge key_clk, negedge rst)
  if (~rst)
    current_state <= NO_KEY_PRESSED;
  else
    current_state <= next_state;


always @ (*)
  case (current_state)    
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


reg       key_pressed_flag;             
reg [3:0] col_val, row_val;           
 

always @ (negedge key_clk, negedge rst)
  if (~rst)
  begin
    col              <= 4'h0;
    key_pressed_flag <=    0;
  end
  else
    case (next_state)
      NO_KEY_PRESSED :                  
      begin
        col              <= 4'h0;
        key_pressed_flag <=    0;      
      end
      SCAN_COL0 :                       
        col <= 4'b1110;
      SCAN_COL1 :                       
        col <= 4'b1101;
      SCAN_COL2 :                   
        col <= 4'b1011;
      SCAN_COL3 :                   
        col <= 4'b0111;
      KEY_PRESSED :                    
      begin
        col_val          <= col;       
        row_val          <= row;       
        key_pressed_flag <= 1;         
      end
    endcase



always @ (negedge key_clk, negedge rst)
  if (~rst)
    boarddata <= 16'h0;
  else
    if (key_pressed_flag)
        case ({col_val, row_val})
            8'b1110_1110 : boarddata <= 4'h1;   
            8'b1110_1101 : boarddata <= 4'h4;
            8'b1110_1011 : boarddata <= 4'h7;
            8'b1110_0111 : boarddata <= 4'hE;
            
            8'b1101_1110 : boarddata <= 4'h2;
            8'b1101_1101 : boarddata <= 4'h5;
            8'b1101_1011 : boarddata <= 4'h8;
            8'b1101_0111 : boarddata <= 4'h0;
            
            8'b1011_1110 : boarddata <= 4'h3;
            8'b1011_1101 : boarddata <= 4'h6;
            8'b1011_1011 : boarddata <= 4'h9;
            8'b1011_0111 : boarddata <= 4'hF;

            8'b0111_1110 : boarddata <= 4'hA;
            8'b0111_1101 : boarddata <= 4'hB;
            8'b0111_1011 : boarddata <= 4'hC;
            8'b0111_0111 : boarddata <= 4'hD;

            // default: boarddata <= boarddata;        
    endcase
endmodule
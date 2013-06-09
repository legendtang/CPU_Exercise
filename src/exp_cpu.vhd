library ieee;
use ieee.std_logic_1164.all;
use work.exp_cpu_components.all;

entity exp_cpu is port
	(
	clk : in std_logic;              -- //系统时钟
	reset : in std_logic;              -- //系统复位信号
	WE : out std_logic;    				-- //读写内存控制信号
	AR : out std_logic_vector(15 downto 0);     -- //读写内存地址
	OB : inout std_logic_vector(15 downto 0)  	-- //外部总线
    reg_sel : in std_logic (5 downto 0);
    reg_content : out std_logic (15 downto 0);
    c_flag : out std_logic;
    z_flag : out std_logic
	);
end exp_cpu;

architecture behav of exp_cpu is
<<<<<<< HEAD
	--instru_fetch out
signal t1,t3: std_logic;
signal pc,pc_inc,IR: std_logic_vector(15 downto 0);
	--decoder_unit out
signal SR,DR: std_logic_vector(3 downto 0);
signal op_code:	std_logic_vector(4 downto 0);
signal jz_instruct,jc_instruct,
       jmp_instruct,jnz_instruct,
       jnc_instruct,jr_instruct: std_logic;
signal DRWr,Mem_Write,dw_instruct,change_z:  std_logic;
signal change_c,sel_memdata: std_logic;
signal r_sjmp_addr: std_logic_vector(15 downto 0);
	--exe_unit out
signal c_tmp,z_tmp,c_z_j_flag: std_logic;
signal Mem_Addr,result,sjmp_addr: std_logic_vector(15 downto 0);
	--memory out
signal data_read,DR_data_out:  std_logic_vector(15 downto 0);
	--regfile out
signal output_DR,output_SR:  std_logic_vector(15 downto 0);
signal c_out,z_out:	 std_logic;  
=======
	-- instru_fetch out
signal t1, t2, t3 : std_logic;
signal pc, pc_inc, IR : std_logic_vector(15 downto 0);
	-- decoder_unit out
signal SR, DR : std_logic_vector(3 downto 0);
signal op_code : std_logic_vector(4 downto 0);
signal zj_instruct, cj_instruct, lj_instruct,
       nzj_instruct, ncj_instruct, rj_instruct : std_logic;
signal DRWr, Mem_Write, dw_instruct, change_z : std_logic;
signal change_c, sel_memdata : std_logic;
signal r_sjmp_addr : std_logic_vector(15 downto 0);
	-- exe_unit out
signal c_tmp, z_tmp, c_z_j_flag : std_logic;
signal Mem_Addr, result, sjmp_addr : std_logic_vector(15 downto 0);
	-- memory out
signal data_read, DR_data_out : std_logic_vector(15 downto 0);
	-- regfile out
signal r0, r1, r2, r3 : std_logic_vector (15 downto 0);
signal output_DR, output_SR : std_logic_vector(15 downto 0);
signal c_out, z_out : std_logic;  

>>>>>>> 811a3297e5ed6406723e9cfa0e3bebbed57b8eac
begin
    test_out : process(reg_sel)
    begin
        case reg_sel is
            when "000000" =>
                reg_content <= r0;
            when "000001" =>
                reg_content <= r1;
            when "000010" =>
                reg_content <= r2;
            when "000011" =>
                reg_content <= r3;
            when "000100" =>
                reg_content <= "0000000" & t3 & "000" & t2 "000" & t1;
            when "111110" =>
                reg_content <= pc;
            when "111111" =>
                reg_content <= ir;
            when others =>
                reg_content <= x"0000";
        end case;
    end process;

G_INSTRU_FETCH : instru_fetch port map
	   (reset => reset,
		clk => clk,		
<<<<<<< HEAD
		data_read => data_read,  --存储器读出的数
		jmp_instruct => jmp_instruct, --来自decoder的长转移指令标志
		DW_instruct => DW_instruct, --来自decoder的双字指令标志
		c_z_j_flag => c_z_j_flag, --为1时进行条件转移，来自EXE
		sjmp_addr => sjmp_addr, --条件转移指令的转移地址，来自EXE
=======
		data_read => data_read,  -- 存储器读出的数
		lj_instruct => lj_instruct, -- 来自decoder的长转移指令标志
		DW_instruct => DW_instruct, -- 来自decoder的双字指令标志
		c_z_j_flag => c_z_j_flag, -- 为1时进行条件转移，来自EXE
		sjmp_addr => sjmp_addr, -- 条件转移指令的转移地址，来自EXE
>>>>>>> 811a3297e5ed6406723e9cfa0e3bebbed57b8eac
		t1 => t1,
        t2 => t2,
		t3 => t3,
		pc => pc,
		pc_inc => pc_inc,
		IR => IR
		); 

G_DECODER : decoder_unit port map
	   (IR => IR,	-- 来自instru_fetch
		SR => SR,   -- 源寄存器号
		DR => DR,	-- 目的寄存器号
		op_code => op_code,  -- ALU运算的操作码
		zj_instruct => zj_instruct, -- 为1时是如果Z=1则转移指令
		cj_instruct => cj_instruct, -- 为1时是如果C=1则转移指令
		lj_instruct => lj_instruct, -- 为1时是无条件长转移指令
        rj_instruct => rj_instruct,
        nzj_instruct => nzj_instruct,
        ncj_instruct => ncj_instruct,
		DRWr => DRWr,  -- 为1时在t3下降沿写DR寄存器,送往regfile
		Mem_Write => Mem_Write,  -- 为1时对存储器进行写操作。
		dw_instruct => dw_instruct, -- 为1时是双字指令
		change_z => change_z,  -- 为1时在t3下降沿根据指令执行结果置Z标志
		change_c => change_c,  -- 为1时在t3下降沿根据指令执行结果置Z标志
		sel_memdata => sel_memdata,  -- 为1时存储器的读出数据作为写入DR的数据
		r_sjmp_addr => r_sjmp_addr -- 相对转移地址
		);
<<<<<<< HEAD
		
G_DECODER:	decoder_unit port map
	   (IR => IR,	--来自instru_fetch
		SR => SR,   --源寄存器号
		DR => DR,	--目的寄存器号
		op_code => op_code,  --ALU运算的操作码
		jnz_instruct => jnz_instruct, --为1时是如果Z=0则转移指令
		jnc_instruct => jnc_instruct, --为1时是如果C=0则转移指令
		jmp_instruct => jmp_instruct, --为1时是无条件长转移指令
        jz_instruct => jz_instruct,
        jc_instruct => jc_instruct,
		DRWr => DRWr,  --为1时在t3下降沿写DR寄存器,送往regfile
		Mem_Write => Mem_Write,  --为1时对存储器进行写操作。
		dw_instruct => dw_instruct, --为1时是双字指令
		change_z => change_z,  --为1时在t3下降沿根据指令执行结果置Z标志
		change_c => change_c,  --为1时在t3下降沿根据指令执行结果置Z标志
		sel_memdata => sel_memdata,  --为1时存储器的读出数据作为写入DR的数据
		r_sjmp_addr => r_sjmp_addr --相对转移地址
		);

G_EXE:	exe_unit port map
		(
	  	t1 => t1,
		op_code => op_code, --ALU运算的操作码，来自decoder
		jnz_instruct => jnz_instruct, --为1时是如果Z=1则转移指令，来自decoder
	  	jnc_instruct => jnc_instruct, --为1时是如果C=1则转移指令，来自decoder
        jc_instruct => jc_instruct,
        jr_instruct => jr_instruct,
        jz_instruct => jz_instruct,
	    pc => pc,  --来自instru_fetch
		pc_inc => pc_inc, --来自instru_fetch
		c_in => c_out,--以前指令产生的进位C，来自regfile
	    z_in => z_out,  --以前指令产生的Z，来自regfile
		Mem_Write => Mem_Write, --存储器写，来自decoder_unit
		c_tmp => c_tmp, --本条指令产生的Z标志送往regfile
		z_tmp => z_tmp, --本条指令产生的Z标志送往regfile
		c_z_j_flag => c_z_j_flag, --为1时进行条件转移，送往instru_fetch
		r_sjmp_addr => r_sjmp_addr,  --相对转移地址，来自decoder
		dw_instruct => dw_instruct,  --双字指令标志，来自decoder，送往
		sjmp_addr =>  sjmp_addr,--条件转移指令的转移地址instru_fetch
		SR_data => output_SR,  --SR寄存器值，来自regfile
		DR_data => output_DR,  --SR寄存器值，来自regfile
		Mem_Addr => Mem_Addr, --存储器地址，送往memory
		result => result  --运算结果，送往regfile
=======

G_EXE : exe_unit port map
		(
	  	t1 => t1,
		op_code => op_code, -- ALU运算的操作码，来自decoder
		zj_instruct => zj_instruct, -- 为1时是如果Z=1则转移指令，来自decoder
	  	cj_instruct => cj_instruct, -- 为1时是如果C=1则转移指令，来自decoder
        nzj_instruct => nzj_instruct,
        ncj_instruct => ncj_instruct,
        rj_instruct => rj_instruct,
	    pc => pc,  -- 来自instru_fetch
		pc_inc => pc_inc, -- 来自instru_fetch
		c_in => c_out,-- 以前指令产生的进位C，来自regfile
	    z_in => z_out,  -- 以前指令产生的Z，来自regfile
		Mem_Write => Mem_Write, -- 存储器写，来自decoder_unit
		c_tmp => c_tmp, -- 本条指令产生的Z标志送往regfile
		z_tmp => z_tmp, -- 本条指令产生的Z标志送往regfile
		c_z_j_flag => c_z_j_flag, -- 为1时进行条件转移，送往instru_fetch
		r_sjmp_addr => r_sjmp_addr,  -- 相对转移地址，来自decoder
		dw_instruct => dw_instruct,  -- 双字指令标志，来自decoder，送往
		sjmp_addr =>  sjmp_addr,-- 条件转移指令的转移地址instru_fetch
		SR_data => output_SR,  -- SR寄存器值，来自regfile
		DR_data => output_DR,  -- SR寄存器值，来自regfile
		Mem_Addr => Mem_Addr, -- 存储器地址，送往memory
		result => result  -- 运算结果，送往regfile
>>>>>>> 811a3297e5ed6406723e9cfa0e3bebbed57b8eac
	    );

G_MEMORY : memory_unit port map
	   (reset => reset,
		clk   => clk,
		t3    => t3, 
		Mem_addr  => Mem_addr,  -- 存储器地址，来自exe_unit
		Mem_Write => Mem_Write, -- 存储器写，来自decoder_unit
		sel_memdata => sel_memdata,  -- 为1时存储器的读出数据作为写入DR的数据，来自decoder

		SR_data => output_SR,-- 写存储器的数据,来自regfile
		result => result, -- 运算结果，来自exe_unit
		rw => WE,  -- 存储器读写信号，送往芯片外部
		ob => ob,  -- 存储器数据总线，和芯片外部存储器数据总线连接
		ar => AR,  -- 存储器地址，送往芯片外部和存储器地址总线连接
		data_read   => data_read, -- 从存储器读出的指令，送往instru_fetch
		DR_data_out => DR_data_out -- 写入DR的数据，送往regfile
		);

G_REGFILE : regfile port map
 	   (DR => DR,  -- DR寄存器号，来自decoder
		SR => SR,  -- SR寄存器号，来自decoder
		reset => reset,
		write => DRWr, -- 寄存器写控制信号，来自decoder                          
		clk => t3,	-- 寄存器写入脉冲，来自instru_fetch，下降沿写入
		d_input => DR_data_out, -- 写入寄存器的数据，来自memory
		change_z => change_z, -- 为1时在t4下降沿根据Z_tmp置Z标志,来自decoder
		change_c => change_c, -- 为1时在t4下降沿根据C_tmp置C标志,来自decoder
	    c_in => c_tmp, -- 本条指令得到的c,来自decoder
	    z_in => z_tmp, -- 本条指令得到的c,来自decoder

		output_DR => output_DR,   -- DR寄存器内容，送往exe和memory     
		output_SR => output_SR,   -- SR寄存器内容，送往exe
		c_out => c_out,  -- C标志，送往exe和exp
		z_out => z_out   -- Z标志，送往exe和exp
	    );

end behav;
<<<<<<< HEAD
=======

>>>>>>> 811a3297e5ed6406723e9cfa0e3bebbed57b8eac

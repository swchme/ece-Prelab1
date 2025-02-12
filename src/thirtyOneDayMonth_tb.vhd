--+----------------------------------------------------------------------------
--| 
--| COPYRIGHT 2017 United States Air Force Academy All rights reserved.
--| 
--| United States Air Force Academy     __  _______ ___    _________ 
--| Dept of Electrical &               / / / / ___//   |  / ____/   |
--| Computer Engineering              / / / /\__ \/ /| | / /_  / /| |
--| 2354 Fairchild Drive Ste 2F6     / /_/ /___/ / ___ |/ __/ / ___ |
--| USAF Academy, CO 80840           \____//____/_/  |_/_/   /_/  |_|
--| 
--| ---------------------------------------------------------------------------
--|
--| FILENAME      : thirtyOneDayMonth_tb.vhd (TEST BENCH)
--| AUTHOR(S)     : Capt Dan Johnson, ***Your Name Here***
--| CREATED       : 12/12/2019 Last Modified 06/24/2020
--| DESCRIPTION   : This file tests to ensure thirtyOneDayMonthMux works properly
--|
--|
--+----------------------------------------------------------------------------
--|
--| REQUIRED FILES :
--|
--|    Libraries : ieee
--|    Packages  : std_logic_1164, numeric_std, unisim
--|    Files     : thirtyOneDayMonth.vhd
--|
--+----------------------------------------------------------------------------
--|
--| NAMING CONVENSIONS :
--|
--|    xb_<port name>           = off-chip bidirectional port ( _pads file )
--|    xi_<port name>           = off-chip input port         ( _pads file )
--|    xo_<port name>           = off-chip output port        ( _pads file )
--|    b_<port name>            = on-chip bidirectional port
--|    i_<port name>            = on-chip input port
--|    o_<port name>            = on-chip output port
--|    c_<signal name>          = combinatorial signal
--|    f_<signal name>          = synchronous signal
--|    ff_<signal name>         = pipeline stage (ff_, fff_, etc.)
--|    <signal name>_n          = active low signal
--|    w_<signal name>          = top level wiring signal
--|    g_<generic name>         = generic
--|    k_<constant name>        = constant
--|    v_<variable name>        = variable
--|    sm_<state machine type>  = state machine type definition
--|    s_<signal name>          = state name
--|
--+----------------------------------------------------------------------------
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  
entity thirtyOneDayMonth_tb is --notice entity is empty.  The testbench has no external connections.
end thirtyOneDayMonth_tb;

architecture test_bench of thirtyOneDayMonth_tb is 
	
  -- declare the component of your top-level design unit under test (UUT) (looks very similar to entity declaration)
  component thirtyoneDayMonth is
    port(
	i_A : in std_logic;
	i_B : in std_logic;
	i_C : in std_logic;
	i_D : in std_logic;
	o_Y : out std_logic
    );	
  end component;

  -- declare any additional components required
  
  signal w_sw : std_logic_vector (3 downto 0):= (others=> '0');
  signal w_Y : std_logic := '0';

  
begin
	-- PORT MAPS ----------------------------------------
	-- map ports for any component instances (port mapping is like wiring hardware)
    thirtyOneDayMonthMux_inst : thirtyOneDayMonth port map (
			i_D => w_sw(3),
			i_C => w_sw(2),
			i_B => w_sw(1),
			i_A => w_sw(0),
	    		o_Y => w_Y
        );
	-----------------------------------------------------

	-- PROCESSES ----------------------------------------	
	-- Test Plan Process --------------------------------
	-- Implement the test plan here.  Body of process is continuous from time = 0  
	test_process : process 
	begin
	w_sw <= x"1"; wait for 10 ns;  -- january (0001)
    assert w_Y = '1' report "Error: January failed" severity failure;
    
    w_sw <= x"3"; wait for 10 ns;  -- march (0011)
    assert w_Y = '1' report "Error: March failed" severity failure;
    
    w_sw <= x"5"; wait for 10 ns;  -- may (0101)
    assert w_Y = '1' report "Error: May failed" severity failure;
    
    w_sw <= x"7"; wait for 10 ns;  -- july (0111)
    assert w_Y = '1' report "Error: July failed" severity failure;
    
    w_sw <= x"8"; wait for 10 ns;  -- august (1000)
    assert w_Y = '1' report "Error: August failed" severity failure;
    
    w_sw <= x"A"; wait for 10 ns;  -- october (1010)
    assert w_Y = '1' report "Error: October failed" severity failure;
    
    w_sw <= x"C"; wait for 10 ns;  -- december (1100)
    assert w_Y = '1' report "Error: December failed" severity failure;
    
    -- Test for months that do NOT have 31 days (should return '0')

    w_sw <= x"2"; wait for 10 ns;  -- f (0010)
    assert w_Y = '0' report "Error: February failed" severity failure;
    
    w_sw <= x"4"; wait for 10 ns;  -- april (0100)
    assert w_Y = '0' report "Error: April failed" severity failure;
    
    w_sw <= x"6"; wait for 10 ns;  -- june (0110)
    assert w_Y = '0' report "Error: June failed" severity failure;
    
    w_sw <= x"9"; wait for 10 ns;  -- september (1001)
    assert w_Y = '0' report "Error: September failed" severity failure;
    
    w_sw <= x"B"; wait for 10 ns;  -- november (1011)
    assert w_Y = '0' report "Error: November failed" severity failure;
    
    wait; -- Keep simulation running
  end process;  	
	-----------------------------------------------------	
	
end test_bench;

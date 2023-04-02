library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bram_tb is
--  Port ( );
end bram_tb;

architecture Behavioral of bram_tb is
  component bram is
    Port (
        clk         : in std_logic;
        rst         : in std_logic;
        read_enable : in std_logic;
        write_enable: in std_logic;
        address_in  : in unsigned(17 downto 0);
        data_bus    : inout std_logic_vector(7 downto 0)
    );
  end component;
  
  signal clk_s          : std_logic := '0';
  signal rst_s          : std_logic := '1';
  signal read_enable_s  : std_logic := '0';
  signal write_enable_s : std_logic := '0';
  signal address_in_s   : unsigned(17 downto 0) := "000000000000000000";
  signal data_bus_s      : std_logic_vector(7 downto 0) := (others => 'Z');
  
begin
    DUT: entity work.bram
    port map (
        clk => clk_s,
        rst => rst_s,
        read_enable => read_enable_s,
        write_enable => write_enable_s,
        address_in => address_in_s,
        data_bus => data_bus_s
    );
  
--    clk_s <= '0', '1' after 10 ns;  
    clock_process : process
    begin
        clk_s <= '0';
        wait for 1 ns;
        clk_s <= '1';
        wait for 1 ns;
    end process clock_process;
    
    test_process : process
    begin
        address_in_s <= "000000000000101010";
        wait for 10 ns;
        rst_s <= '0';
        data_bus_s <= "11111111";
        wait for 1 ns;
        write_enable_s <= '1', '0' after 3 ns;
        wait for 5 ns;
        data_bus_s <= (others => 'Z');
        wait for 20 ns;
        address_in_s <= "000000000000101011";
        data_bus_s <= "11110000";
        wait for 1 ns;
        write_enable_s <= '1', '0' after 3 ns;
        wait for 5 ns;
        data_bus_s <= (others => 'Z');
        wait for 20 ns;
        address_in_s <= "000000001000101011";
        data_bus_s <= "11100000";
        wait for 1 ns;
        write_enable_s <= '1', '0' after 3 ns;
        wait for 5 ns;
        data_bus_s <= (others => 'Z');
        wait for 20 ns;
        address_in_s <= "000000000000101010";
        read_enable_s <= '1', '0' after 5 ns;
        wait for 20 ns;
        address_in_s <= "000000000000101011";
        read_enable_s <= '1', '0' after 5 ns;
        wait for 20 ns;
        address_in_s <= "000000001000101011";
        read_enable_s <= '1', '0' after 5 ns;
        wait;
    end process test_process;
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test is
  Port (
    clk         : in std_logic;
    rst         : in std_logic;
    port_in     : in std_logic_vector(7 downto 0);
    address_in  : in unsigned(17 downto 0);
    write_enable: in std_logic;
    read_enable : in std_logic;
    port_out    : out std_logic_vector(7 downto 0)
  );
end test;

architecture Behavioral of test is
component bram
  Port (
  clk           : in std_logic;
  rst           : in std_logic;
  read_enable   : in std_logic;
  write_enable  : in std_logic;
  address_in    : in unsigned(17 downto 0);
  data_bus      : inout std_logic_vector(7 downto 0)
);
end component;
signal internal : std_logic_vector(7 downto 0) := (others => 'Z');
begin
    bram_inst : bram port map (
        clk => clk,
        rst => rst,
        read_enable => read_enable,
        write_enable => write_enable,
        address_in => address_in,
        data_bus => internal
    );
    process(clk)
    begin
        if rising_edge(clk) then
            if read_enable = '1' then
                port_out <= internal;
            end if;
            if write_enable = '1' then
                internal <= port_in;
            else
                internal <= (others => 'Z');
            end if;
        end if;
    end process;
end architecture Behavioral;
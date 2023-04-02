library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bram is
  Port (
    clk         : in std_logic;
    rst         : in std_logic;
    read_enable : in std_logic;
    write_enable: in std_logic;
    address_in  : in unsigned(17 downto 0);
    data_bus    : inout std_logic_vector(7 downto 0) := (others => 'Z')
  );
end bram;

architecture Behavioral of bram is
    type ram_type is array (0 to 839) of STD_LOGIC_VECTOR (7 downto 0); --163839
    signal ram : ram_type := (others => (others => '0'));
    
    attribute ram_style : string;
    attribute ram_style of ram : signal is "block";

    signal data_out: std_logic_vector(7 downto 0) := (others => 'Z');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if write_enable = '1' then
                ram(to_integer(address_in)) <= data_bus;
            end if;

            if read_enable = '1' then
                data_out <= ram(to_integer(address_in));
            end if;
            
            if read_enable = '1'  and rst = '0' then
                data_bus <= data_out;
            else
                data_bus <= (others => 'Z');
            end if;
        end if;
    end process;
end architecture Behavioral;
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge

@cocotb.test()
async def test_bcd_counter_basic(dut):

    cocotb.start_soon(Clock(dut.clk, 100, units="ns").start())

    dut.rst_n.value = 0
    dut.ui_in.value = 0

    for _ in range(5):
        await RisingEdge(dut.clk)

    dut.rst_n.value = 1
    dut.ui_in[0].value = 1

    for _ in range(15):
        await RisingEdge(dut.clk)

    units = int(dut.uo_out.value & 0x0F)
    tens  = int((dut.uo_out.value >> 4) & 0x0F)

    assert units == 5
    assert tens == 1

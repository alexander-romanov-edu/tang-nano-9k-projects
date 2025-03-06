YOSYS = yosys
NEXTPNR = nextpnr-gowin
NEXTPNR_DEVICE = GW1NR-LV9QN88PC6/I5
NEXTPNR_FAMILY = GW1N-9C
APICULA = gowin_pack
IVERILOG = iverilog
IVERILOG_FLAGS = -g2009
VVP = vvp

BUILD_DIR = build

.PHONY: all

modules = $(wildcard src/modules/*.v)
testbenches = $(basename $(notdir $(wildcard src/testbenches/*.v)))

all: $(addsuffix .vcd,$(addprefix $(BUILD_DIR)/,$(testbenches)))

$(BUILD_DIR):
	mkdir $(BUILD_DIR)

$(BUILD_DIR)/%: src/testbenches/%.v $(modules) $(BUILD_DIR)
	$(IVERILOG) $(IVERILOG_FLAGS) $^ -o $@

$(BUILD_DIR)/%.vcd: $(BUILD_DIR)/%
	cd $(BUILD_DIR) && $(VVP) $(notdir $<)

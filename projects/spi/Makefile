YOSYS = yosys
NEXTPNR = nextpnr-himbaechel
NEXTPNR_DEVICE = GW1NR-LV9QN88PC6/I5
NEXTPNR_FAMILY = GW1N-9C
APICULA = gowin_pack
IVERILOG = iverilog
IVERILOG_FLAGS = -g2009
VVP = vvp

BUILD_DIR = build
CLKFREQ = 27000000

.PHONY: all

modules = $(wildcard src/modules/*.v)
testbenches = $(basename $(notdir $(wildcard src/testbenches/*.v)))

all: $(addsuffix .vcd,$(addprefix $(BUILD_DIR)/,$(testbenches))) $(BUILD_DIR)/top.fs

$(BUILD_DIR):
	mkdir $(BUILD_DIR)

$(BUILD_DIR)/%: src/testbenches/%.v $(modules) $(BUILD_DIR)
	$(IVERILOG) $(IVERILOG_FLAGS) $^ -o $@

$(BUILD_DIR)/%.vcd: $(BUILD_DIR)/%
	cd $(BUILD_DIR) && $(VVP) $(notdir $<)

$(BUILD_DIR)/top.json: $(modules) src/top.v
	$(YOSYS) -p "plugin -i systemverilog" -p "read_systemverilog src/top.v $(modules); synth_gowin -json $(BUILD_DIR)/top.json"

$(BUILD_DIR)/pnrtop.json: $(BUILD_DIR)/top.json boards/tangnano9k.cst
	$(NEXTPNR) --json $< --write $@ --device $(NEXTPNR_DEVICE) \
		--vopt cst=boards/tangnano9k.cst --vopt family=$(NEXTPNR_FAMILY)

$(BUILD_DIR)/top.fs: $(BUILD_DIR)/pnrtop.json
	$(APICULA) -d $(NEXTPNR_FAMILY) -o $@ $<

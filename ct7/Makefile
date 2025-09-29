PROG = rmstinit rmskernel rmsfront rmssecfront rmsstdfront rmsstdsecfront rmstmdb rmsuserapi rmsprediction riskapimgr dataxcenterapimgr rmscompositor rmsarb priceestimator rmssettle foxgateway ctpriskapimgr rmspe rmsdscmgr
TOOL = ../tools/flowviewer ../tools/stdflowviewer ../tools/flowchk ../tools/slogparser ../tools/dumptool ../tools/tcpudptool ../tools/encryptiontool ../tools/genprivatekeybase64 ../tools/testcrypt ../tools/pricediff ../tools/riskmonitor ../tools/risklatencytool ../tools/gtest/main
SHARELIB = business/estimate
all:
	@for dir in $(PROG) $(TOOL) $(SHARELIB); do \
		echo "pumping $$dir..."; \
		$(MAKE) -C $$dir pump || echo "pump $$dir failed"; \
		echo "building $$dir..."; \
		$(MAKE) -C $$dir || echo "building $$dir failed"; \
	done

clean:
	@for dir in $(PROG) $(TOOL) $(SHARELIB); do \
		echo "Cleaning $$dir..."; \
		$(MAKE) -C $$dir clean || echo "clean $$dir failed"; \
	done

pump:
	@for dir in $(PROG) $(SHARELIB) $(TOOL); do \
		echo "pumping $$dir..."; \
		$(MAKE) -C $$dir pump || echo "pump $$dir failed"; \
	done

.PHONY: all process pump clean $(PROG) $(TOOL) $(SHARELIB)

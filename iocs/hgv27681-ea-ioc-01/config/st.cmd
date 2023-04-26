cd "$(TOP)"

dbLoadDatabase "dbd/ioc.dbd"
ioc_registerRecordDeviceDriver(pdbbase)

# simDetectorConfig(portName, maxSizeX, maxSizeY, dataType, maxBuffers, maxMemory)
simDetectorConfig("hgv27681.CAM", 2560, 2160, 1, 50, 0)

# NDPvaConfigure(portName, queueSize, blockingCallbacks, NDArrayPort, NDArrayAddr, pvName, maxMemory, priority, stackSize)
NDPvaConfigure("hgv27681.PVA", 2, 0, "hgv27681.CAM", 0, "hgv27681-EA-TST-01:IMAGE", 0, 0, 0)
startPVAServer

# instantiate Database records for Sim Detector
dbLoadRecords (simDetector.template, "P=hgv27681-EA-TST-01, R=:CAM:, PORT=hgv27681.CAM, TIMEOUT=1, ADDR=0")
dbLoadRecords (NDPva.template, "P=hgv27681-EA-TST-01, R=:PVA:, PORT=hgv27681.PVA, ADDR=0, TIMEOUT=1, NDARRAY_PORT=hgv27681.CAM, NDARRAY_ADR=0, ENABLED=1")
# also make Database records for DEVIOCSTATS
dbLoadRecords(iocAdminSoft.db, "IOC=hgv27681-EA-IOC-01")
dbLoadRecords(iocAdminScanMon.db, "IOC=hgv27681-EA-IOC-01")

# start IOC shell
iocInit

# poke some records
dbpf "hgv27681-EA-TST-01:CAM:AcquirePeriod", "0.1"

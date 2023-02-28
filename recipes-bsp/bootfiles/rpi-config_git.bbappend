
SRCREV = "648ffc470824c43eb0d16c485f4c24816b32cd6f"

do_deploy:append() {

    #################################################
    # Enable Full PCI DMA Access
    #################################################

    echo "# Enable PCI DMA Access" >>$CONFIG
    echo "dtoverlay=pcie-32bit-dma-overlay" >>$CONFIG
  

}
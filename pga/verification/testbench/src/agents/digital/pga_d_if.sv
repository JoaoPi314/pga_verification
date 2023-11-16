interface pga_d_if;
    logic [2:0] VCVGA;
    logic PD;

    modport mst(output VCVGA, PD);
    modport slv(input VCVGA, PD);

endinterface : pga_d_if
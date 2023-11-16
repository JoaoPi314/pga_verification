interface pga_d_if;
    logic [7:0] gain;

    modport mst(output gain);
    modport slv(input gain);

endinterface : pga_d_if
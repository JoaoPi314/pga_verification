# define the database for the waveforms
database -open waves -into waves.shm -default

#   probe all
probe -create -database waves -all -depth all

# # run simulation
run
exit

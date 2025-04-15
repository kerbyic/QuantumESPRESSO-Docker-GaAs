FROM rockylinux:9

# Get the required packages using dnf
# Starting with the basics
RUN dnf install -y \
    rsync \
    make \
    gcc \
    gcc-c++ \
    gcc-gfortran \
    openmpi \
    openblas \
    procps-ng \
    bzip2 \
    git \
    cmake

# Then the develelopment libraries
RUN dnf install -y --enablerepo=devel \
    openblas-devel \
    openmpi-devel \
    lapack-devel \
    fftw-devel

# And finally extra packages for enterprise linux 9
RUN dnf install -y --enablerepo=crb https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
RUN dnf install -y \
    scalapack-openmpi-devel \
    hdf5-devel \
    gnuplot

# Add the MPI executables to the system PATH
ENV PATH=$PATH:/usr/lib64/openmpi/bin

# Disable message passing through the NIC or shared memory interfaces
ENV PSM3_DEVICES=self

# Create a QE user to run as
RUN useradd qe
USER qe

# Copy and extract the build files
ARG QE_VER
WORKDIR /home/qe
RUN git clone https://gitlab.com/QEF/q-e --tag qe-${QE_VER}

# Build  Quantum Espresso
ARG BUILD_THREADS
WORKDIR /home/qe/qe-${QE_VER}/build
RUN cmake -DCMAKE_Fortran_COMPILER=mpif90 -DCMAKE_C_COMPILER=mpicc -DCMAKE_INSTALL_PREFIX="/home/qe/qe-${QE_VER}/bin" ..
RUN make -j${BUILD_THREADS}

# Set default threading and add Quantum Espresso (pw.x) to PATH
ENV OMP_NUM_THREADS=1
ENV PATH=$PATH:/home/qe/qe-${QE_VER}/build/bin

# Change to the data directory and run
WORKDIR /mnt/data
CMD [ "./run.sh" ]
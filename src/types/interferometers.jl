### Interferometers ###

abstract type Interferometer end

struct UserDefinedInterferometer <: Interferometer

    #actively checks unitarity, inefficient if outputing many matrices that are known to be unitary
    m::Int
    U::Matrix
    UserDefinedInterferometer(U) = is_unitary(U) ? new(size(U,1), U) : error("input matrix is non unitary")
end

struct RandHaar <: Interferometer
    m::Int
    U::Matrix{ComplexF64}
    RandHaar(m) = new(m,rand_haar(m))
end

struct Fourier <: Interferometer
    m::Int
    U::Matrix{ComplexF64}
    Fourier(m::Int) = new(m,fourier_matrix(m))
end

struct Hadamard <: Interferometer
    m::Int
    U::Matrix
    Hadamard(m::Int) = new(m,hadamard_matrix(m))
end

struct BeamSplitter <: Interferometer
    transmission_amplitude::Float64
    U::Matrix
    m::Int
    BeamSplitter(transmission_amplitude) = new(transmission_amplitude, beam_splitter(transmission_amplitude),2)
end

struct Rotation <: Interferometer
    angle::Float64
    U::Matrix
    m::Int
    Rotation(angle) = new(angle, rotation_matrix(angle),2)
end

struct PhaseShift <: Interferometer
    shifted_modes::Array
    param_::Array
    m::Int
    U::Matrix
    PhaseShift(shifted_modes, param_) = new(shifted_modes, param_, length(shifted_modes), phase_shift(shifted_modes, param_))
end

Base.show(io::IO, interf::Interferometer) = print(io, "Interferometer :\n\n", "Type : ", typeof(interf), "\n", "m : ", interf.m)

Base.show(io::IO, interf::UserDefinedInterferometer) = begin
     print(io, "Interferometer :\n\n", "Type : ", typeof(interf), "\n", "m : ", interf.m, "\nUnitary : \n")
     pretty_table(io, interf.U)
end

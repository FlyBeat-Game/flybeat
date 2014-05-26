function h = fht(x)
    f = fft(x);
    h = (real(f)-imag(f));
end

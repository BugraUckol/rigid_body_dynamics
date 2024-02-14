function E = ANGLEMAP(E)

for i = 1:3
    E(i) = mod(E(i), 2 * pi);

    if E(i) > pi
        E(i) = E(i) - 2 * pi;
    end
end

end
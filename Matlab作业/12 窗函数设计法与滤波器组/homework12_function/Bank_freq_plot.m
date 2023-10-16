function Bank_freq_plot(f, y, N)
    num = 1;
    bank = 1;
    figure();
    for i = 1 : N
        if ~mod(i, 21)
            figure();
            num = 1;
        end
        subplot(5, 4, num); plot(f, y(bank, :));
        bank = bank + 1;
        num = num + 1;
    end
end


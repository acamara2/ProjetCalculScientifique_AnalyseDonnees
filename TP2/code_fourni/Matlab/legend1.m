function legend1()

xlabel('version (4 = dsyev)');
ylabel('temps normalis�s');
lg = legend('m = 100', ...
    'm = 500', ...
    'Location','Best');
set(lg,'Interpreter','Latex');
end


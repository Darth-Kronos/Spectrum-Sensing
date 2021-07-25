function [gp] = find_gp(samples)
   gp = exp(mean(log(abs(samples)))); 
end


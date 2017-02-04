function error = error_uniform(u,w)
    angle = acos((u*w')/(norm(u)*norm(w)));
    error = angle / pi;
end
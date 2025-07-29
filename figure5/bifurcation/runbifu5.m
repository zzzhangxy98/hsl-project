ppt=5;
parpool("Processes",32)
load('paraset.mat')
tmpparaset=paraset(ppt,1:29);

parfor jpoint=1:length(tmpparaset)
    opt=tmpparaset{jpoint};
    if isempty(opt)
        continue
    else
        bifu4point(opt,ppt,jpoint);
    end
end


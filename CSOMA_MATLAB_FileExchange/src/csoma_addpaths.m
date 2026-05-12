function csoma_addpaths()
%CSOMA_ADDPATHS Add CSOMA source and examples to the MATLAB path.

    root = fileparts(fileparts(mfilename('fullpath')));
    addpath(fullfile(root, 'src'));
    addpath(genpath(fullfile(root, 'examples')));
end

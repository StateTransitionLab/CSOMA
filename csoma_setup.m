function csoma_setup()
%CSOMA_SETUP Add CSOMA toolbox folders to the MATLAB path.
%
%   Run this once after downloading or cloning the repository:
%       csoma_setup

    root = fileparts(mfilename('fullpath'));

    addpath(fullfile(root, 'src'));
    addpath(genpath(fullfile(root, 'examples')));
    addpath(fullfile(root, 'replication'));

    fprintf('CSOMA toolbox paths added successfully.\n');
end

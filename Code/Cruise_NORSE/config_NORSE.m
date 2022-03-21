%% config_NORSE.m
% Usage: Called from get_config('NORSE') in BowChain_master
% Description: Creates a basic deployment configuration structure for all
%              BowChain/Tchain deployments.
% Inputs: none
% Outputs: config structure
%
% Author: Dylan Winters (dylan.winters@oregonstate.edu)
% Created: 2021-06-20
% modified: 2021-09-01 A Sanchez-Rios (asanchezrios@ucsd.edu) for NORSE pilot Cu

function config = config_NORSE()

%% Set some global default options for deployments
defaults = struct();

% This is the simplest model for initial processing -- just assume that the
% chain is vertical and compressing like a spring. Get the depth coordinate of
% each sensor by interpolating between pressure sensors.

% For the first analysis, I usually start with 'cm_straight' (ASR)
%    defaults.chain_model = 'cm_straight';
   defaults.chain_model = 'cm_segmented';

% We should do a "dunk" to calibrate sensor clocks eventually.
%    defaults.time_offset_method = 'cohere';
%  defaults.time_offset_method = 'known_drift';
%   defaults.time_synched = [2010 09 10 8 00 00];
%   defaults
%   defaults.cohere_interval = [2021 09 10 8 40 24, 2021 09 10 8  36];

% Set this to true to force re-parsing of raw data even if .mat files already
% exist. Useful in case we find mistakes in parsing functions and need to
% correct them.
defaults.raw2mat = false;

% Use the earliest and latest timestamp of all sensors if the start/end time
% aren't specified. Just in case we're missing a section_start_end_time.csv.
defaults.dn_range = [-inf inf];

% Grid-averaging settings
defaults.bin_method = 'none';
defaults.bin_dt = 10;
defaults.bin_dz = 1;
defaults.bin_zlim = [-20 0];

%%

% Modify user_directories.m for your data location. For me this returns
% '/home/data/NORSE/Tchain', but everyone's local copy will probably be
% different.
dir_raw = fullfile(user_directories('NORSE'),'raw');

%% Create deployment-specific configurations
% This is where having a consistent file structure does 90% of the work for us!
% The expected format should look like this:
%
% └── Tchain
%     └── raw
%         └── Aries
%             └── deploy_20210618
%                 ├── 060088_20210618_2140.rsk
%                 ├── 077416_20210618_1644.rsk
%                 ├── 077561_20210618_1649.rsk
%                 ├── 077565_20210618_1647.rsk
%                 ├── 077566_20210618_2148.rsk
%                 ├── 077568_20210618_2141.rsk
%                 ├── 101179_20210618_2145.rsk
%                 ├── 101180_20210618_2136.rsk
%                 ├── instrument_depths.csv
%                 ├── README.txt
%                 └── section_start_end_time.csv

vessel_raw_folders = dir(fullfile(dir_raw));

% The next line is not neededin NORSE because we only have on vessel, The
% ARMSTRONG, comment this out for different set up (ASR)
% vessel_names = setdiff({vessel_raw_folders.name},{'.','..', '.DS_Store', '._.DS_Store'});
vessel_names = {'Armstrong'};
ndep = 0;
% for v = 1:length(vessel_names) % Comment this out because we only have
% one vessel
deployments = dir(fullfile(dir_raw,'deployment*'));
for i = 1:length(deployments)
    ndep = ndep + 1;
    config(ndep).name = deployments(i).name;
    
    %Change for NORSE because we only have one boat
    %         config(ndep).vessel = vessel_names{v};
    config(ndep).vessel = vessel_names{1};
    
    % Read the sensors.csv file for instrument deployment positions
    t = readtable(fullfile(deployments(i).folder,deployments(i).name,'instrument_depths.csv'));
    config(ndep).sensor_sn = num2cell(t.serialnum);
    config(ndep).sensor_pos = t.depth_m_;
    config(ndep).sensor_offset = t.dt;
    
    % Try to read start & end time
    try
        t = readtable(fullfile(deployments(i).folder,deployments(i).name,'section_start_end_time.csv'));
        config(ndep).dn_range = datenum([t.start_time t.end_time]);
    catch err
        % Default to full sensor time range if this fails
        config(ndep).dn_range = [-inf inf];
    end
    
    % Set raw data directory
    config(ndep).dir_raw = fullfile(deployments(i).folder,deployments(i).name);
    
    % Set processed data directory
    config(ndep).dir_proc = strrep(config(ndep).dir_raw,'/raw/','/processed/');
    
    
end
% end
config = fill_defaults(config,defaults);

%% We can specify any deployment- or vessel-specific settings here
% There are a bunch of possible ways to do this, below is one example:
for i = 1:length(config)
    switch config(i).vessel
        
        
        % Configure Armstrong
        case 'Armstrong'
            switch config(i).name
                case 'deployment_1'
                    
                    % Set the zero_pressure_interval
                    config(i).zero_pressure_interval = datenum([2021 09 05 10 30 00; 2021 09 05 11 36 00]);
                    
                    % Set lat and lon
                    config(i).file_gps= '/Volumes/science_share/underway/underway_AR6002.mat';
                    
                case 'deployment_2'
                    
                    % Set the zero_pressure_interval
                    config(i).zero_pressure_interval = datenum([2021 09 10 8 01 00; 2021 09 10 8 3 00]);
                    
                    % Set lat and lon
                    config(i).file_gps= '/Volumes/science_share/underway/underway_AR6002.mat';
                    
                case 'deployment_3'
                    
                    % Set the zero_pressure_interval
                    config(i).zero_pressure_interval = datenum([2021 09 15 11 00 00; 2021 09 15 12 00 00]);
                    
                    % Set lat and lon
                    config(i).file_gps= '/Volumes/science_share/underway/underway_AR6002.mat';
                    
                case 'deployment_4'
                    
                    % Set the zero_pressure_interval
                     config(i).zero_pressure_interval = datenum([2021 09 16 20 00 00; 2021 09 16 21 00 00]);
                    
                    % Set lat and lon
                    config(i).file_gps= '/Volumes/science_share/underway/underway_AR6002.mat';
                    
                         case 'deployment_5'
                    
                    % Set the zero_pressure_interval
                     config(i).zero_pressure_interval = datenum([2021 09 26 20 30 00; 2021 09 26 21 12 00]);
                    
                    % Set lat and lon
                    config(i).file_gps= '/Volumes/science_share/underway/underway_AR6002.mat';
                    
                    
                                    case 'deployment_6'
                    
                    % Set the zero_pressure_interval
%                      config(i).zero_pressure_interval = datenum([2021 09 30 15 26 00; 2021 09 30 15 36 00]);
                    
                    % Set lat and lon
                    config(i).file_gps= '/Volumes/science_share/underway/underway_AR6002.mat';
                    
                         case 'deployment_7'
                    
                    % Set the zero_pressure_interval
                      config(i).zero_pressure_interval = datenum([2021 10 01 15 24 00; 2021 10 01 15 33 00]);
                    
                    % Set lat and lon
                    config(i).file_gps= '/Volumes/science_share/underway/underway_AR6002.mat';
                    
                    
                    
                    
                    
            end
    end
end


%% End of config_SUNRISE
% After running
%   >> tchain = BowChain_master('SUNRISE','Aries','deploy_20210618')
% you should have a file structure like this:
%
% └── Tchain
%     ├── processed
%     │   └── Aries
%     │       └── deploy_20210618
%     │           ├── 060088_20210618_2140.mat
%     │           ├── 077416_20210618_1644.mat
%     │           ├── 077561_20210618_1649.mat
%     │           ├── 077565_20210618_1647.mat
%     │           ├── 077566_20210618_2148.mat
%     │           ├── 077568_20210618_2141.mat
%     │           ├── 101179_20210618_2145.mat
%     │           └── 101180_20210618_2136.mat
%     └── raw
%         └── Aries
%             └── deploy_20210618
%                 ├── 060088_20210618_2140.rsk
%                 ├── 077416_20210618_1644.rsk
%                 ├── 077561_20210618_1649.rsk
%                 ├── 077565_20210618_1647.rsk
%                 ├── 077566_20210618_2148.rsk
%                 ├── 077568_20210618_2141.rsk
%                 ├── 101179_20210618_2145.rsk
%                 ├── 101180_20210618_2136.rsk
%                 ├── instrument_depths.csv
%                 ├── README.txt
%                 └── section_start_end_time.csv

% And the output, tchain, looks like this:
%
% >> tchain
% tchain =
%   struct with fields:
%       dn: [1x29111 double]
%        t: [8x29111 double]
%        p: [8x29111 double]
%        s: [8x29111 double]
%        x: [8x29111 double]
%        z: [8x29111 double]
%      pos: [8x1 double]
%     info: [1x1 struct]

% You can run BowChain_master('SUNRISE',vessel_name,deploy_name) like this to
% process an individual deployment, or BowChain_master('SUNRISE') to process all
% deployments.

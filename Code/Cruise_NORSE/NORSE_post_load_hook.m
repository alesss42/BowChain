function [data, cfg] = SUNRISE_post_load_hook(data,cfg)

% Note: I don't recommend modifying this in the version we're using as a group.
% The purpose of these hook functions is to arbitrarily modify the data at any
% stage in processing to do custom, user-specific tasks.
idx = find(strcmp({cfg.sensors.sn},'60523'));
if ~isempty(idx)
    tmp = data{idx}.p;
    data{idx}.p = data{idx}.t;
    data{idx}.t = tmp;
    
    data{idx}.s = gsw_SP_from_C(data{idx}.c, data{idx}.t, 0);
end

inoem = find(strcmp({cfg.name},'deployment_2'));

if ~isempty(inoem)
    % path for offsets
    load('/Users/alesanchez-rios/Documents/NORSE CRUISE/cruise_mfiles/Bow_chain/raw/deployment_2/offsets_deployment_2.mat');
    % solor first
    
    for ii =1:length(solo)
        
        idx2 = find(strcmp({cfg.sensors.sn},{solo{ii}.sn}));
        if ~isempty(idx2)
            disp('IM HERE')
            data{idx2}.dn = data{idx2}.dn +solo{ii}.offset;
        end
        
        for ii=1:length(conc)
            idx2 = find(strcmp({cfg.sensors.sn},{conc{ii}.sn}));
            if ~isempty(idx2)
                disp('IM HERE')
                data{idx2}.dn = data{idx2}.dn +conc{ii}.offset;
            end
        end
        
        %     for ii = 1:length(cfg.sensor_sn)
        % %         %      idx3 = find(strcmp({cfg.sensors.sn},'207048'));
        %          data{ii}.dn = data{ii}.dn + cfg.sensor_offset(ii);
        %
        %     end
        
    end
end

inoem = find(strcmp({cfg.name},'deployment_3'));

if ~isempty(inoem)
    % path for offsets
    load('/Users/alesanchez-rios/Documents/NORSE CRUISE/cruise_mfiles/Bow_chain/raw/deployment_3/offsets_deployment_3b.mat');
    % solor first
    
    for ii =1:length(solo)
        
        idx2 = find(strcmp({cfg.sensors.sn},{solo{ii}.sn}));
        if ~isempty(idx2)
            disp(['IM HERE solo', num2str(ii)])
            data{idx2}.dn = data{idx2}.dn +solo{ii}.offset;
        end
        
        
        
        %     for ii = 1:length(cfg.sensor_sn)
        % %         %      idx3 = find(strcmp({cfg.sensors.sn},'207048'));
        %          data{ii}.dn = data{ii}.dn + cfg.sensor_offset(ii);
        %
        %     end
        
    end
    
    for ii=1:length(conc)
        idx2 = find(strcmp({cfg.sensors.sn},{conc{ii}.sn}));
        if ~isempty(idx2)
            disp(['IM HERE conc', num2str(ii)])
            data{idx2}.dn = data{idx2}.dn +conc{ii}.offset;
        end
    end
end


inoem = find(strcmp({cfg.name},'deployment_5'));

if ~isempty(inoem)
    % path for offsets
    load('/Users/alesanchez-rios/Documents/NORSE CRUISE/cruise_mfiles/Bow_chain/raw/deployment_5/offsets_deployment_5.mat');
    % solor first
    
    for ii =1:length(solo)
        
        idx2 = find(strcmp({cfg.sensors.sn},{solo{ii}.sn}));
        if ~isempty(idx2)
            disp(['IM HERE solo', num2str(ii)])
            data{idx2}.dn = data{idx2}.dn +solo{ii}.offset;
        end
        
        
        
        %     for ii = 1:length(cfg.sensor_sn)
        % %         %      idx3 = find(strcmp({cfg.sensors.sn},'207048'));
        %          data{ii}.dn = data{ii}.dn + cfg.sensor_offset(ii);
        %
        %     end
        
    end
    
    for ii=1:length(conc)
        idx2 = find(strcmp({cfg.sensors.sn},{conc{ii}.sn}));
        if ~isempty(idx2)
            disp(['IM HERE conc', num2str(ii)])
            data{idx2}.dn = data{idx2}.dn +conc{ii}.offset;
        end
    end
end

inoem = find(strcmp({cfg.name},'deployment_6'));



if ~isempty(inoem)
    % path for offsets
    load('/Users/alesanchez-rios/Documents/NORSE CRUISE/cruise_mfiles/Bow_chain/raw/deployment_6/offsets_deployment_6.mat');
    % solor first
    
    for ii =1:length(solo)
        
        idx2 = find(strcmp({cfg.sensors.sn},{solo{ii}.sn}));
        if ~isempty(idx2)
            disp(['IM HERE solo', num2str(ii)])
            data{idx2}.dn = data{idx2}.dn +solo{ii}.offset;
        end
        
        
        
        %     for ii = 1:length(cfg.sensor_sn)
        % %         %      idx3 = find(strcmp({cfg.sensors.sn},'207048'));
        %          data{ii}.dn = data{ii}.dn + cfg.sensor_offset(ii);
        %
        %     end
        
    end
    
    for ii=1:length(conc)
        idx2 = find(strcmp({cfg.sensors.sn},{conc{ii}.sn}));
        if ~isempty(idx2)
            disp(['IM HERE conc', num2str(ii)])
            data{idx2}.dn = data{idx2}.dn +conc{ii}.offset;
            
            % Correcting manually for pressure because of the time
            % frequency problem
            data{idx2}.p = data{idx2}.p - 10.1 ;
            disp(['Removing 10.1 from pressure in concertto = ', num2str(ii)])
        end
    end
end


inoem = find(strcmp({cfg.name},'deployment_7'));



if ~isempty(inoem)
    % path for offsets
    load('/Users/alesanchez-rios/Documents/NORSE CRUISE/cruise_mfiles/Bow_chain/raw/deployment_7/offsets_deployment_.mat');
    % solor first
    
    for ii =1:length(solo)
        
        idx2 = find(strcmp({cfg.sensors.sn},{solo{ii}.sn}));
        if ~isempty(idx2)
            disp(['IM HERE solo', num2str(ii)])
            data{idx2}.dn = data{idx2}.dn +solo{ii}.offset;
        end
        
        
        
        %     for ii = 1:length(cfg.sensor_sn)
        % %         %      idx3 = find(strcmp({cfg.sensors.sn},'207048'));
        %          data{ii}.dn = data{ii}.dn + cfg.sensor_offset(ii);
        %
        %     end
        
    end
    
    for ii=1:length(conc)
        idx2 = find(strcmp({cfg.sensors.sn},{conc{ii}.sn}));
        if ~isempty(idx2)
            disp(['IM HERE conc', num2str(ii)])
            data{idx2}.dn = data{idx2}.dn +conc{ii}.offset;
            
            % Correcting manually for pressure because of the time
            % frequency problem
%             data{idx2}.p = data{idx2}.p - 10.1 ;
%             disp(['Removing 10.1 from pressure in concertto = ', num2str(ii)])
        end
    end
end





end
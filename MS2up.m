%% MS2

%% PATH TO METADATA
%info = readtable('~/Google Drive/MATLAB_R_scripts/metadata MS2.txt','Delimiter','\t')
%% 
clear variables

MetaFile = '';
MetaFile = ' enhprom';
MetaFile = ' ecNICD';
%MetaFile = ' javier';

%MetaFile = ' mutBG';
%MetaFile = ' other';
%MetaFile = ' 2c';


info = readtable(['~/Google Drive jf565/MATLAB_R_scripts/metadata MS2 3D',MetaFile,'.txt'],'ReadVariableNames', true,'Delimiter', '\t');
%
Paths  = info.Path;
Files = info.File;
Names = info.Name
Nicknames = info.Nickname
Reps = info.Rep; 
From = info.From;
nc14 = info.nc14;
To = string(info.To);
TimeRes = info.TimeRes;
Delay = info.Delay;
Flip = info.Flip; Flip = cellfun(@(x) str2num(x),Flip,'UniformOutput',false);
Notes = info.Notes;
%
%writetable(info,'~/Google Drive/MATLAB_R_scripts/metadata MS2 3D.txt','Delimiter','\t')

%%
GUI_TraceSelector(info);

%clearvars('-except', 'Paths','Files','Names');
%% for x = [1:length(Files)]
Index = find(cellfun(@(x) ~isempty(x),regexp(info.Nickname, '^simMSEpsimE$')))';
%Index = find(info.Delay >= 60)';

%Index = find(cellfun(@(x) isempty(x),regexp(info.Nickname, 'ng')))';

info.Nickname(Index)
%for x = 146
%for x = Index%67,75:82. 52:56,59, 84:87, 90-94. 1:67 redone %60 missing AT. repeat main 109 
for x = [177] %67,75:82. 52:56,59, 84:87, 90-94. 1:67 redone %60 missing AT. repeat main 109 
    % repeaat sim twi3. sim + 10(only AT)
    % from 66 saved right Data.mat
    %try
    % error 16,17,40,65,69
    % 59 crashed
    % 83 crashed for timestamp
    %60 crashed for AT
    disp(x)
    set(0, 'DefaulttextInterpreter', 'none')
    %mainNBs(Paths{x}, Files{x}, Names{x},false)
    Divisions = 1; Spots = 0;
    parameters = {Paths{x}, Files{x}, Names{x},Nicknames{x}, Reps(x),From(x),nc14(x),To{x}, TimeRes(x), Delay(x),Flip{x}, Notes{x}, Divisions, Spots};
    %parameters = {Paths{x}, Files{x}, '_3D_spots/',Nicknames{x}, Reps(x),From(x),nc14(x),To{x}, TimeRes(x), Delay(x),Flip{x}, Notes{x}, Divisions, Spots};
  %     MS2_TimeStampAll(Paths{x},Files{x},Names{x},0)
MS2_macroImageJ(Paths{x}, Files{x},0);  mainMS2_3D_fromBF(parameters,false)
         AnalyzeTraces(1,1,Spots, info, x); %first arg is manual, second regions (0 no regions, 1 draw/rerun, 2 overwrite), third spots
    clearvars('-except','Index','info', 'Paths','Files','Names','Nicknames','Reps','From','nc14','To','TimeRes','Delay','Flip','Notes'); 
   %end
end 
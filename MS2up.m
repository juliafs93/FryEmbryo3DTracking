%% MS2

%% PATH TO METADATA
%info = readtable('~/Google Drive/MATLAB_R_scripts/metadata MS2.txt','Delimiter','\t')
%% 
clear variables

MetaFile = '';
MetaFile = ' enhprom';
MetaFile = ' ecNICD';

%MetaFile = ' mutBG';
%MetaFile = ' other';


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

%%
GUI_TraceSelector(info);

%clearvars('-except', 'Paths','Files','Names');
%% for x = [1:length(Files)]
%Index = find(cellfun(@(x) ~isempty(x),regexp(info.Nickname, '^simMSEpsimE$')))';
%Index = find(info.Delay >= 60)';
%info.Nickname(Index)

for x = [1] 
    disp(x)
    set(0, 'DefaulttextInterpreter', 'none')

    Divisions = 1; Spots = 0;
    parameters = {Paths{x}, Files{x}, Names{x},Nicknames{x}, Reps(x),From(x),nc14(x),To{x}, TimeRes(x), Delay(x),Flip{x}, Notes{x}, Divisions, Spots};
    %parameters = {Paths{x}, Files{x}, '_3D_spots/',Nicknames{x}, Reps(x),From(x),nc14(x),To{x}, TimeRes(x), Delay(x),Flip{x}, Notes{x}, Divisions, Spots};

	MS2_macroImageJ(Paths{x}, Files{x},0);  mainMS2_3D_fromBF(parameters,false)
         AnalyzeTraces(1,1,Spots, info, x); %first arg is manual, second regions (0 no regions, 1 draw/rerun, 2 overwrite), third spots
    clearvars('-except','Index','info', 'Paths','Files','Names','Nicknames','Reps','From','nc14','To','TimeRes','Delay','Flip','Notes'); 
end 
%%
clear all
%Path = '/Users/julia/Google Drive jf565/comp MS2/OnOff/';
PathMain = '/Users/julia/Google Drive jf565/comp MS2/bursting';
mkdir(PathMain)

MetaFile = '';
%MetaFile = ' enhprom';
MetaFile = ' ecNICD';
%MetaFile = ' mutBG';

info = readtable(['~/Google Drive jf565/MATLAB_R_scripts/metadata MS2 3D',MetaFile,'.txt'],'ReadVariableNames', true);

Exps = cell2table(info.Nickname, 'VariableNames',{'Nickname'});
Exps.Rep = info.Rep;
for x=1:size(Exps,1); Exp{x} = [Exps.Nickname{x},' ',num2str(Exps.Rep(x))];end
Exps.Exp = Exp';

close all
%PaletteMain = [142,183,36;61,131,183;105,139,34;54,100,139;62,81,16;33,63,86;130,130,130;80,80,80;]./255;

PaletteMain = [130,130,130;80,80,80; %grey1, grey2. 1,2
    142,183,36;105,139,34;62,81,16; %green1,green2,green3. 3:5
    61,131,183;54,100,139;33,63,86; %blue1,blue2,blue3. 6:8
    250,174,64;226,140,26; %yellow1, yellow2. 9:10
    167,51,170;104,15,107; %pink1, pink2. 11:12
    78,69,139; 54, 44,96; %pruple1, purple2. 13:14
    205,55,0]./255; %red. 15
    

Input{1}.Nicknames = {'^simMSEpeve \+$','^simMSEpeve eveNICD$','^simMSEpeve 2xeveNICD$'}
Input{1}.ExpLabels = {'WT','eve-NICD','2xeve-NICD'};
Input{1}.Selections = {'ME','ME','ME'};
Input{1}.Palette = PaletteMain([6:8],:);


Input{2}.Nicknames = {'^simMSEpeve \+$','^simMSEpeve eveNICD$','^simMSEpeve eveNICDtwi$'}
Input{2}.ExpLabels = {'WT','eve-NICD','eve-NICD-twi'};
Input{2}.Selections = {'ME','ME','ME'};
Input{2}.Palette = PaletteMain([6,7,10],:);


Input{3}.Nicknames = {'^simMSEpeve \+$','^simMSEpeveSPS \+$','^simMSEpeve eveNICD$','^simMSEpeveSPS eveNICD$'}
Input{3}.ExpLabels = {'+ WT','SPS WT','+ NICD','SPS NICD'};
Input{3}.Selections = {'ME','ME','ME','ME'};
Input{3}.Palette = PaletteMain([1,6,2,7],:);
%Input{3}.Palette = PaletteMain([4,7,2,8],:);


Input{4}.Nicknames = {'^m8NEpeve \+$','^m8NEpeve eveNICD$'}
Input{4}.ExpLabels = {'m8NE WT','m8NE eveNICD'};
Input{4}.Selections = {'ME','ME'};
Input{4}.Palette = PaletteMain([13,14],:);


Input{5}.Nicknames = {'^m5m8pevel eveNICD$','^m5m8pevel 2xeveNICD$'}
Input{5}.ExpLabels = {'eve-NICD','2xeve-NICD'};
Input{5}.Selections = {'DE','DE'};
Input{5}.Palette = PaletteMain([3,4],:);


Input{6}.Nicknames = {'^m5m8peve \+$','^m5m8peveiSPS \+$','^m5m8peve eveNICD$','^m5m8peveiSPS eveNICD$'}
Input{6}.ExpLabels = {'m5m8 +','m5m8iSPS +','m5m8 1x','m5m8iSPS 1x'};
Input{6}.Selections = {'MSE','MSE','MSE','MSE'};
Input{6}.Palette = PaletteMain([1,3,2,4],:);


Input{7}.Nicknames = {'^simMSEpeve \+$','^simMSEpeveSPS \+$','^simMSEpeve eveNICD$','^simMSEpeveSPS eveNICD$'}
Input{7}.ExpLabels = {'sim +','simSPS +','sim 1x','simSPS 1x'};
Input{7}.Selections = {'MSE','MSE','MSE','MSE'};
Input{7}.Palette = PaletteMain([1,6,2,7],:);



% combined m5m8 DE and sim ME
Input{8}.Nicknames = [Input{5}.Nicknames,Input{1}.Nicknames];
Input{8}.ExpLabels = [Input{5}.ExpLabels,Input{1}.ExpLabels];
Input{8}.Selections = [Input{5}.Selections,Input{1}.Selections];
Input{8}.Palette = [Input{5}.Palette;Input{1}.Palette];


% combined m5m8DE and m8NE ME
Input{9}.Nicknames = [Input{5}.Nicknames,Input{4}.Nicknames];
Input{9}.ExpLabels = [Input{5}.ExpLabels,Input{4}.ExpLabels];
Input{9}.Selections = [Input{5}.Selections,Input{4}.Selections];
Input{9}.Palette = [Input{5}.Palette;Input{4}.Palette];

Input{10}.Nicknames = {'^m5m8peve \+$','^m5m8peveDtwi \+$','^m5m8peveDdl \+$','^m5m8peve eveNICD$','^m5m8peveDtwi eveNICD$','^m5m8peveDdl eveNICD$'}
Input{10}.ExpLabels = {'m5m8 +','m5m8Dtwi +','m5m8Ddl +','m5m8 1x','m5m8Dtwi 1x','m5m8Ddl 1x'};
Input{10}.Selections = {'MSE','MSE','MSE','MSE','MSE','MSE','MSE'};
Input{10}.Palette = PaletteMain([1,9,11,2,10,12],:);

Input{11}.Nicknames = {'^m5m8peve \+$','^m5m8peveDtwi \+$','^m5m8peveDdl \+$','^m5m8peveDtwidl \+$','^m5m8peve eveNICD$','^m5m8peveDtwi eveNICD$','^m5m8peveDdl eveNICD$','^m5m8peveDtwidl eveNICD$'}
Input{11}.ExpLabels = {'m5m8 +','m5m8Dtwi +','m5m8Ddl +','m5m8Dtwidl +','m5m8 1x','m5m8Dtwi 1x','m5m8Ddl 1x','m5m8Dtwidl 1x'};
Input{11}.Selections = {'MSE','MSE','MSE','MSE','MSE','MSE','MSE','MSE','MSE'};
Input{11}.Palette = PaletteMain([1,9,11,3,2,10,12,4],:);

Input{12}.Nicknames = {'^m5m8pevel eveNICD$','^m5m8pevel eveNICDtwi$','^simMSEpevel eveNICD$','^simMSEpevel eveNICDtwi$'}
Input{12}.ExpLabels = {'m5m8 NICD','m5m8 NICDtwi','sim NICD','sim NICDtwi'};
Input{12}.Selections = {'NE','NE','NE','NE'};
Input{12}.Palette = PaletteMain([1,4,2,7],:);

Input{13}.Nicknames = {'^m5m8pevel eveNICD$','^m5m8pevel eveNICDtwi$','^m5m8pevel eveNICDdl$','^simMSEpevel eveNICD$','^simMSEpevel eveNICDtwi$'}
Input{13}.ExpLabels = {'m5m8 NICD','m5m8 NICDtwi','m5m8 NICDdl','sim NICD','sim NICDtwi'};
Input{13}.Selections = {'DE','DE','DE','DE','DE'};
Input{13}.Palette = PaletteMain([1,4,5,2,7],:);

Input{14}.Nicknames = {'^m5m8pevel eveNICD$','^m5m8peveDtwil eveNICD$','^m5m8peveDdll eveNICD$'}
Input{14}.ExpLabels = {'m5m8 1x','m5m8Dtwi 1x','m5m8Ddl 1x'};
Input{14}.Selections = {'DE','DE','DE','DE'};
Input{14}.Palette = PaletteMain([2,10,12],:);

Input{15}.Nicknames = {'^m5m8peve \+$','^m5m8peveDtwi \+$','^m5m8peveDdl \+$','^m5m8peveDtwidl \+$','^m8NEpeve \+$','^m5m8peve eveNICD$','^m5m8peveDtwi eveNICD$','^m5m8peveDdl eveNICD$','^m5m8peveDtwidl eveNICD$','^m8NEpeve eveNICD$',}
Input{15}.ExpLabels = {'m5m8 +','m5m8Dtwi +','m5m8Ddl +','m5m8Dtwidl +','m8NE +','m5m8 1x','m5m8Dtwi 1x','m5m8Ddl 1x','m5m8Dtwidl 1x','m8NE 1x'};
Input{15}.Selections = {'MSE','MSE','MSE','MSE','MSE','MSE','MSE','MSE','MSE','MSE','MSE'};
Input{15}.Palette = PaletteMain([1,9,11,3,13,2,10,12,4,14],:);

Limits = [0, 90];
minNumb = 10; Smooth = 3; minOn = 5; minPDis = 10; SplitShortLong = 60; SplitEarly = 15;

MinContinuous = 10; %min t (min) at least one burst length

Jitter = 0.6; %Jitter./2 cant be > BarW
BarW = 0.4;
FaceAlpha = 0.3;
DotSize = 0.03;
LineWidth = 1.5;
FontSizeTitle = 10;
FontSize = 8;

%%
clear all
PathMain = '/Users/julia/Google Drive jf565/comp MS2/bursting';
mkdir(PathMain)

MetaFile = ' enhprom';

info = readtable(['~/Google Drive jf565/MATLAB_R_scripts/metadata MS2 3D',MetaFile,'.txt'],'ReadVariableNames', true);

Exps = cell2table(info.Nickname, 'VariableNames',{'Nickname'});
Exps.Rep = info.Rep;
for x=1:size(Exps,1); Exp{x} = [Exps.Nickname{x},' ',num2str(Exps.Rep(x))];end
Exps.Exp = Exp';

close all

PaletteMain = [130,130,130;80,80,80; %grey1, grey2. 1,2
    142,183,36;105,139,34;62,81,16; %green1,green2,green3. 3:5
    61,131,183;54,100,139;33,63,86; %blue1,blue2,blue3. 6:8
    250,174,64;226,140,26; %yellow1, yellow2. 9:10
    167,51,170;104,15,107; %pink1, pink2. 11:12
    78,69,139; 54, 44,96; %purple1, purple2. 13:14
    205,55,0]./255; %red. 15

Input{1}.Nicknames = {'^m5m8peve$','^simMSEpeve$','^m8NEpeve$',}
Input{1}.ExpLabels = {'m5m8','sim','m8NE'};
Input{1}.Selections = {'MSE','MSE','MSE'};
Input{1}.Palette = PaletteMain([1,2,13],:);

Input{2}.Nicknames = {'^m5m8peve$','^simMSEpeve$'}
Input{2}.ExpLabels = {'m5m8','sim'};
Input{2}.Selections = {'MSE','MSE'};
Input{2}.Palette = PaletteMain([3,6],:);

% Nicknames = {'^m5m8peve$','^m5m8hsp70$','^m5m8pm5$','^m5m8pm6$','^m5m8pm7$','^m5m8pm8$','^m5m8psimE$'}
% ExpLabels = {'peve','hsp70','pm5','pm6','pm7','pm8','psimE'};
% Selection = 'EarlyOnly';
% Limits = [-50, 15];
% minNumb = 10; Smooth = 3; minOn = 5; minPDis = 10; SplitShortLong = 60; SplitEarly = -50;

Limits = [0, 90];
minNumb = 10; Smooth = 3; minOn = 5; minPDis = 10; SplitShortLong = 60; SplitEarly = 15;


MinContinuous = 10; %min t (min) at least one burst length

Jitter = 0.6; %Jitter./2 cant be > BarW
BarW = 0.4;
FaceAlpha = 0.3;
DotSize = 0.03;
LineWidth = 1.5;
FontSizeTitle = 10;
FontSize = 8;
%%
%for e = [1,3,6,9,11]
for e = [2,1]
%for e = 1:length(Input)
%%

Nicknames = Input{e}.Nicknames;
ExpLabels = Input{e}.ExpLabels;
Selections = Input{e}.Selections;
Palette = Input{e}.Palette;  
    
    
MaxRow = length(Nicknames);
BNumAll = cell(1,MaxRow);
BLenAll = cell(1,MaxRow);
BPerAll = cell(1,MaxRow);
BAmpAll = cell(1,MaxRow);
OffTimeAll = cell(1,MaxRow);
BSizeAll = cell(1,MaxRow);
OnsetAll = cell(1,MaxRow);
EndAll = cell(1,MaxRow);
TmAll = cell(1,MaxRow);

RepNumOn = cell(1,MaxRow);
RepBNumAll = cell(1,MaxRow);
RepBLenAll = cell(1,MaxRow);
RepBPerAll = cell(1,MaxRow);
RepBAmpAll = cell(1,MaxRow);
RepOffTimeAll = cell(1,MaxRow);
RepBSizeAll = cell(1,MaxRow);
RepOnsetAll = cell(1,MaxRow);

NumOn = [];
PercOn = [];
PercCont = [];
MaxCol = 1;

for Exp = 1:length(Nicknames)
    Index = find(cellfun(@(x) ~isempty(x),regexp(info.Nickname, Nicknames{Exp},'match')))
    info.Nickname(Index)
     MaxCol = max(MaxCol,length(Index));
    Selection = Selections{Exp};
for i = [1:length(Index)]
        x = Index(i);
        %
        Parameters = info(x,:);
        Table2Vars(Parameters);
        Flip = str2double(strsplit(Flip,','));
        PathToSave = [Path,File,Name,File]; 
        %load([PathToSave, '_Stats.mat']);
        %minNumb = 10; Smooth = 3; minOn = 5; minPDis = 10; SplitShortLong = 60; SplitEarly = 15;
        Merged_meanF_maxGFP = Read3d([PathToSave, '_maxF_maxGFP.tiff']);
        boundariesL = Read3d([PathToSave, '_boundariesL.tiff']);
        F = max(round(35*60/TimeRes)+nc14-Delay,1);
        Im = Merged_meanF_maxGFP(:,:,F)./255;
        Width = size(Im,1); Height = size(Im,2);
        clear CentroidF;
        load([PathToSave,'_Data.mat']);
        if length(fields(Data)) > 2
            Struct2Vars(Data);
        else
            Data = Data.Data;
            Struct2Vars(Data);
        end
        
        try
            ImLab = CentroidF;
        catch
        
            ImLab = boundariesL(:,:,max(1,F-5):min(F+5,Frames));
            for f = 1:size(ImLab,3)
                Stats{f} = regionprops('table',ImLab(:,:,f),'Centroid');
                Stats{f}.Label = [1:height(Stats{f})]';
            end
            [AllF] = MergeAll(Stats, TimeRes);
            AllF = splitvars(AllF);
            Labels = unique(AllF.Label); LabelsOld = Labels;
            [CentXF] = Reshape(AllF,Frames,Labels,'Centroid_1','Label');
            [CentYF] = Reshape(AllF,Frames,Labels,'Centroid_2','Label');
            PosX = nanmean(CentXF,1);
            PosY = nanmean(CentYF,1);
             PosX(isnan(PosX)) = [];
             PosY(isnan(PosY)) = [];
%             StatsF = Stats_GFP{F};
%             CentXF = StatsF.Centroid(:,1);
%             CentYF = StatsF.Centroid(:,2);
            Indices = sub2ind([size(Im,1),size(Im,2)],floor(PosY), floor(PosX));
            ImLab = zeros(size(Im,1),size(Im,2));
            ImLab(Indices) = 1;
            Data.CentroidsF = ImLab;
            save([PathToSave,'_Data.mat'],'Data');
        end
        


      %

        if strcmp(Selection,'ME') | strcmp(Selection,'MSE') | strcmp(Selection,'NE') | strcmp(Selection,'DE') == 1
            disp('here')
            %mkdir([Path,File,Name,'regions/'])
             PathToSave = [Path,File,Name,'regions/',File]; 
            %
                Regions = imread([PathToSave,'_regions.tiff']);
                cmap_3 = [255,120,120;096,085,176;95,181,241]./255;
                mkdir([Path,File,Name,'regions/'])
                PathToSave = [Path,File,Name,'regions/',File]; 
                Selected = find([Properties.Type=='ShortMidline'|Properties.Type=='LongMidline']);
            %LabelsSelected = Labels(Selected);
            PosX = floor(nanmean(CentX(max(1,F-5): min(F+5,Frames),Selected),1));
            PosY = floor(nanmean(CentY(max(1,F-5): min(F+5,Frames),Selected),1));
            Indices = sub2ind(size(Regions),PosY,PosX);
            Selected = Selected(~isnan(Indices));
            %LabelsSelected = LabelsSelected(~isnan(Indices));
            Indices = Indices(~isnan(Indices));
            RegionsInd = Regions(Indices);
            switch Selection
                case 'ME'
                    Value = 1;
                case 'MSE' 
                    Value = 2;
                case 'NE'
                    Value = 3;
                case 'DE' 
                    Value = 4;
            end
            
            Selected = Selected(RegionsInd==Value);
            %TotalCells = length(unique(ImLab.*(Regions == Value))) - 1;
            TotalCells = ImLab.*(Regions == Value);
            TotalCells = sum(TotalCells(:));
            %figure;imagesc(ImLab)
        end
        
        if strcmp(Selection,'EarlyOnly')
            Selected = find([Properties.Type=='EarlyOnly']); 
            TotalCells = length(unique(ImLab)) - 1;
        end
     
        TimeScale = ([1:Frames] - nc14+Delay).*TimeRes./60;
        SplitEarlyF = max([SplitEarly*60./TimeRes+nc14-Delay,1]);
        %VarName = varname(ME);
        NormF = (MaxF-Baseline').*Baseline(1)./Baseline'.*2.^(12-Bits);
        OnOff = CleanOnOff(OnOff,minOn);
        [OnOff] = CleanNaNs(MedFilt,OnOff, minOn*2);
        try
            [BurstNum,BurstLength,BurstPeriod,BurstPeak,BurstMax,OffTime,BurstSize] = CountBursts(NormF,OnOff, Selected,minOn,SplitEarlyF,TimeRes);
        catch
            BurstNum = {}; BurstLength = {}; BurstPeriod = {}; BurstPeak = {};BurstMax = {}; OffTime = {}; BurstSize = {};
        end
        Onsets = Properties.Onset(Selected);
        Ends = Properties.End(Selected);
        TotmRNA = Properties.TotalmRNA(Selected);

%         figure(FBNum) ; subplot(MaxRow,MaxCol,MaxCol*(Exp-1)+i);...
%             boxplot([BurstNum{:}]); ylim([0,10])
%         figure(FBLength); subplot(MaxRow,MaxCol,MaxCol*(Exp-1)+i);...
%             boxplot([BurstLength{:}]*TimeRes/60); ylim([0,20])
%         figure(FBPeriod); subplot(MaxRow,MaxCol,MaxCol*(Exp-1)+i);...
%             boxplot([BurstPeriod{:}]*TimeRes/60); ylim([0,20])
%         figure(FBAmp); subplot(MaxRow,MaxCol,MaxCol*(Exp-1)+i);...
%             boxplot([BurstMax{:}]); ylim([0,3000])
        % % cells on
        NumOn(i,Exp) = length(Selected);
        PercOn(i,Exp) = length(Selected) ./ TotalCells;
        Continuous = cellfun(@(x)any(x > MinContinuous.*60./TimeRes),BurstLength);
        PercCont(i,Exp) = sum(Continuous)./length(Continuous);
        NumOn(NumOn == 0) = NaN;
        PercCont(PercOn == 0) = NaN;
        PercOn(PercOn == 0) = NaN;
        PercOn(PercOn > 1) = 1;
        BNumAll{Exp} = [BNumAll{Exp}; [BurstNum{:}]'];
        BLenAll{Exp} = [BLenAll{Exp}; abs([BurstLength{:}]')];
        BPerAll{Exp} = [BPerAll{Exp}; [BurstPeriod{:}]'];
        BAmpAll{Exp} = [BAmpAll{Exp}; [BurstMax{:}]'];
        OffTimeAll{Exp} = [OffTimeAll{Exp}; [OffTime{:}]'];
        BSizeAll{Exp} = [BSizeAll{Exp}; [BurstSize{:}]'];
        OnsetAll{Exp} = [OnsetAll{Exp}; [Onsets(:)]];
        EndAll{Exp} = [EndAll{Exp}; [Ends(:)]];
        TmAll{Exp} = [TmAll{Exp}; [TotmRNA(:)]];


        RepNumOn{Exp} = [RepNumOn{Exp};i];
        RepBNumAll{Exp} = [RepBNumAll{Exp};repmat(i,length([BurstNum{:}]),1)];
        RepBLenAll{Exp} = [RepBLenAll{Exp};repmat(i,length([BurstLength{:}]),1)];
        RepBPerAll{Exp} = [RepBPerAll{Exp};repmat(i,length([BurstPeriod{:}]),1)];
        RepBAmpAll{Exp} = [RepBAmpAll{Exp};repmat(i,length([BurstMax{:}]),1)];
        RepOffTimeAll{Exp} = [RepOffTimeAll{Exp};repmat(i,length([OffTime{:}]),1)];
        RepBSizeAll{Exp} = [RepBSizeAll{Exp};repmat(i,length([BurstSize{:}]),1)];
        RepOnsetAll{Exp} = [RepOnsetAll{Exp};repmat(i,length([Onsets]),1)];


end
end
%
BNumAll = Cell2Mat(BNumAll);
BLenAll = Cell2Mat(BLenAll);
BPerAll = Cell2Mat(BPerAll);
BAmpAll = Cell2Mat(BAmpAll);
OffTimeAll = Cell2Mat(OffTimeAll);
BSizeAll = Cell2Mat(BSizeAll);
OnsetAll = Cell2Mat(OnsetAll);
EndAll = Cell2Mat(EndAll);
TmAll = Cell2Mat(TmAll);


RepNumOn = Cell2Mat(RepNumOn);
RepBNumAll = Cell2Mat(RepBNumAll);
RepBLenAll = Cell2Mat(RepBLenAll);
RepBPerAll = Cell2Mat(RepBPerAll);
RepBAmpAll = Cell2Mat(RepBAmpAll);
RepOffTimeAll = Cell2Mat(RepOffTimeAll);
RepBSizeAll = Cell2Mat(RepBSizeAll);
RepOnsetAll = Cell2Mat(RepOnsetAll);


%%

    
FileOut = [PathMain,'/comp_bursting_',cell2mat(join(unique(Selections),'_')),'_',cell2mat(join(ExpLabels,'_vs_')),'.pdf']
    %Fig = figure('PaperSize',[10*length(Nicknames) Height],'resize','off', 'visible','on','Units','points');
        Fig = figure('PaperUnits','inches','PaperSize',[5.5*length(Nicknames) 3],'Units','points','resize','off', 'visible','on','DefaultAxesFontSize', 4);
set(0,'defaultAxesFontSize',4)
      set(0, 'DefaultFigureRenderer', 'painters');
          set(gcf,'defaultLegendAutoUpdate','off')


%   set(Fig,'defaultAxesFontSize',6)
 %     set(Fig, 'DefaultFigureRenderer', 'painters');

CMAP = bone(MaxCol+1);
CMAP = zeros(size(CMAP))+0.7;
CMAP(:,4) = FaceAlpha;
Cat = repmat([1:1:length(Nicknames)],2,1)+[-BarW./2;BarW./2];

subplot(1,8,1); 
CatX = repmat([1:1:length(Nicknames)],size(NumOn,1),1);
gscatter(CatX(:)+(rand(length(CatX(:)),1)-0.5).*Jitter, NumOn(:), RepNumOn(:),CMAP,'.',5); hold on
patch([Cat;flip(Cat)],[repmat(quantile(NumOn,0.25),2,1);repmat(quantile(NumOn,0.75),2,1)],'red','EdgeColor','none','FaceAlpha',FaceAlpha); hold on
plot(Cat,repmat(nanmean(NumOn),2,1),'-','DisplayName','mean','Color',[0.6980,0.0941,0.1686],'LineWidth',LineWidth)
%plot(Cat,repmat(quantile(NumOn,0.25)*100,2,1),'-','DisplayName','Q1','Color',[0.6980,0.0941,0.1686,0.8],'LineWidth',LineWidth)
%plot(Cat,repmat(quantile(NumOn,0.75)*100,2,1),'-','DisplayName','Q3','Color',[0.6980,0.0941,0.1686,0.8],'LineWidth',LineWidth)
errorbar([1:1:length(Nicknames)],nanmean(NumOn), nanstd(NumOn), nanstd(NumOn),'Color',[0.6980,0.0941,0.1686,0.8],'LineStyle','none','LineWidth',0.5)
legend off
xticks([1:1:length(Nicknames)])
xticklabels(ExpLabels)
%set(findobj(gca, 'type', 'line'), 'linew',2)
%set(findall(gca,'type','text'),'fontSize',4,'fontWeight','bold')
set(gca,'FontSize',FontSize)
title('# active cells','FontSize',FontSizeTitle); box off; 
xlim([0+Jitter,length(Nicknames)+Jitter]); 


subplot(1,8,2); 
CatX = repmat([1:1:length(Nicknames)],size(PercOn,1),1);
gscatter(CatX(:)+(rand(length(CatX(:)),1)-0.5).*Jitter, PercOn(:)*100, RepNumOn(:),CMAP,'.',5); hold on
patch([Cat;flip(Cat)],[repmat(quantile(PercOn,0.25)*100,2,1);repmat(quantile(PercOn,0.75)*100,2,1)],'red','EdgeColor','none','FaceAlpha',FaceAlpha); hold on
plot(Cat,repmat(nanmedian(PercOn)*100,2,1),'-','DisplayName','mean','Color',[0.6980,0.0941,0.1686],'LineWidth',LineWidth)
%plot(Cat,repmat(quantile(NumOn,0.25)*100,2,1),'-','DisplayName','Q1','Color',[0.6980,0.0941,0.1686,0.8],'LineWidth',LineWidth)
%plot(Cat,repmat(quantile(NumOn,0.75)*100,2,1),'-','DisplayName','Q3','Color',[0.6980,0.0941,0.1686,0.8],'LineWidth',LineWidth)
%errorbar([1:1:length(Nicknames)],nanmean(PercOn)*100, nanstd(PercOn)*100, nanstd(PercOn)*100,'Color',[0.6980,0.0941,0.1686,0.8],'LineStyle','none','LineWidth',0.5)
legend off
xticks([1:1:length(Nicknames)])
xticklabels(ExpLabels)
%set(findobj(gca, 'type', 'line'), 'linew',2)
%set(findall(gca,'type','text'),'fontSize',4,'fontWeight','bold')
set(gca,'FontSize',FontSize)
title('% active cells','FontSize',FontSizeTitle); box off; 
%ylim([0,100]);
xlim([0+Jitter,length(Nicknames)+Jitter]); 


subplot(1,8,3); 
CatX = repmat([1:1:length(Nicknames)],length(BNumAll),1);
h = gscatter(CatX(:)+(rand(length(CatX(:)),1)-0.5).*Jitter, BNumAll(:), RepBNumAll(:),CMAP,'.',DotSize);hold on
patch([Cat;flip(Cat)],[repmat(quantile(BNumAll,0.25),2,1);repmat(quantile(BNumAll,0.75),2,1)],'red','EdgeColor','none','FaceAlpha',FaceAlpha); hold on
plot(Cat,repmat(nanmedian(BNumAll),2,1),'-','DisplayName','mean','Color',[0.6980,0.0941,0.1686],'LineWidth',LineWidth)
%plot(Cat,repmat(quantile(BNumAll,0.25),2,1),'-','DisplayName','Q1','Color',[0.6980,0.0941,0.1686,0.8],'LineWidth',LineWidth)
%plot(Cat,repmat(quantile(BNumAll,0.75),2,1),'-','DisplayName','Q3','Color',[0.6980,0.0941,0.1686,0.8],'LineWidth',LineWidth)
%errorbar([1:1:length(Nicknames)],nanmean(BNumAll), nanstd(BNumAll), nanstd(BNumAll),'Color',[0.6980,0.0941,0.1686,0.8],'LineStyle','none','LineWidth',0.5)
legend off
xticks([1:1:length(Nicknames)])
xticklabels(ExpLabels)
set(gca,'FontSize',FontSize)
title('# bursts per cell','FontSize',FontSizeTitle); box off;xlim([0+Jitter,length(Nicknames)+Jitter]); 
%set(findobj(gca, 'type', 'line'), 'linew',2)

subplot(1,8,6); 
CatX = repmat([1:1:length(Nicknames)],length(BLenAll),1);
h = gscatter(CatX(:)+(rand(length(CatX(:)),1)-0.5).*Jitter, BLenAll(:)*TimeRes/60, RepBLenAll(:),CMAP,'.',DotSize);hold on
patch([Cat;flip(Cat)],[repmat(quantile(BLenAll,0.25)*TimeRes/60,2,1);repmat(quantile(BLenAll,0.75)*TimeRes/60,2,1)],'red','EdgeColor','none','FaceAlpha',FaceAlpha); hold on
plot(Cat,repmat(nanmedian(BLenAll)*TimeRes/60,2,1),'-','DisplayName','mean','Color',[0.6980,0.0941,0.1686],'LineWidth',LineWidth)
%plot(Cat,repmat(quantile(BLenAll,0.25)*TimeRes/60,2,1),'-','DisplayName','Q1','Color',[0.6980,0.0941,0.1686,0.8],'LineWidth',LineWidth)
%plot(Cat,repmat(quantile(BLenAll,0.75)*TimeRes/60,2,1),'-','DisplayName','Q3','Color',[0.6980,0.0941,0.1686,0.8],'LineWidth',LineWidth)
%errorbar([1:1:length(Nicknames)],nanmean(BLenAll*TimeRes/60), nanstd(BLenAll*TimeRes/60)*0, nanstd(BLenAll*TimeRes/60),'Color',[0.6980,0.0941,0.1686,0.8],'LineStyle','none','LineWidth',0.5)
legend off
xticks([1:1:length(Nicknames)])
xticklabels(ExpLabels)
set(gca,'FontSize',FontSize)
%set(gca, 'YScale', 'log')
title('burst length (min)','FontSize',FontSizeTitle); box off;xlim([0+Jitter,length(Nicknames)+Jitter]); 
%set(findobj(gca, 'type', 'line'), 'linew',2)

subplot(1,8,7); 
CatX = repmat([1:1:length(Nicknames)],length(BPerAll),1);
h = gscatter(CatX(:)+(rand(length(CatX(:)),1)-0.5).*Jitter, BPerAll(:)*TimeRes/60, RepBPerAll(:),CMAP,'.',DotSize);hold on
patch([Cat;flip(Cat)],[repmat(quantile(BPerAll,0.25)*TimeRes/60,2,1);repmat(quantile(BPerAll,0.75)*TimeRes/60,2,1)],'red','EdgeColor','none','FaceAlpha',FaceAlpha); hold on
plot(Cat,repmat(nanmedian(BPerAll)*TimeRes/60,2,1),'-','DisplayName','mean','Color',[0.6980,0.0941,0.1686],'LineWidth',LineWidth)
%plot(Cat,repmat(quantile(BPerAll,0.25)*TimeRes/60,2,1),'-','DisplayName','Q1','Color',[0.6980,0.0941,0.1686,0.8],'LineWidth',LineWidth)
%plot(Cat,repmat(quantile(BPerAll,0.75)*TimeRes/60,2,1),'-','DisplayName','Q3','Color',[0.6980,0.0941,0.1686,0.8],'LineWidth',LineWidth)
%errorbar([1:1:length(Nicknames)],nanmean(BPerAll*TimeRes/60), nanstd(BPerAll*TimeRes/60)*0, nanstd(BPerAll*TimeRes/60),'Color',[0.6980,0.0941,0.1686,0.8],'LineStyle','none','LineWidth',0.5)
legend off
xticks([1:1:length(Nicknames)])
xticklabels(ExpLabels)
set(gca,'FontSize',FontSize)
%set(gca, 'YScale', 'log')
title('burst period (min)','FontSize',FontSizeTitle); box off;xlim([0+Jitter,length(Nicknames)+Jitter]); 
%set(findobj(gca, 'type', 'line'), 'linew',2)

subplot(1,8,4); 
CatX = repmat([1:1:length(Nicknames)],length(BAmpAll),1);
h = gscatter(CatX(:)+(rand(length(CatX(:)),1)-0.5).*Jitter, BAmpAll(:), RepBAmpAll(:),CMAP,'.',DotSize);hold on
patch([Cat;flip(Cat)],[repmat(quantile(BAmpAll,0.25),2,1);repmat(quantile(BAmpAll,0.75),2,1)],'red','EdgeColor','none','FaceAlpha',FaceAlpha); hold on
plot(Cat,repmat(nanmedian(BAmpAll),2,1),'-','DisplayName','mean','Color',[0.6980,0.0941,0.1686],'LineWidth',LineWidth)
%plot(Cat,repmat(quantile(BAmpAll,0.25),2,1),'-','DisplayName','Q1','Color',[0.6980,0.0941,0.1686,0.8],'LineWidth',LineWidth)
%plot(Cat,repmat(quantile(BAmpAll,0.75),2,1),'-','DisplayName','Q3','Color',[0.6980,0.0941,0.1686,0.8],'LineWidth',LineWidth)
%errorbar([1:1:length(Nicknames)],nanmean(BAmpAll), nanstd(BAmpAll)*0, nanstd(BAmpAll),'Color',[0.6980,0.0941,0.1686,0.8],'LineStyle','none','LineWidth',0.5)
legend off
xticks([1:1:length(Nicknames)])
xticklabels(ExpLabels)
set(gca,'FontSize',FontSize)
%set(gca, 'YScale', 'log')
title('burst amplitude (AU)','FontSize',FontSizeTitle); box off;xlim([0+Jitter,length(Nicknames)+Jitter]); 
%set(findobj(gca, 'type', 'line'), 'linew',2)


subplot(1,8,5); 
CatX = repmat([1:1:length(Nicknames)],length(OffTimeAll),1);
h = gscatter(CatX(:)+(rand(length(CatX(:)),1)-0.5).*Jitter, OffTimeAll(:)*TimeRes/60, RepOffTimeAll(:),CMAP,'.',DotSize);hold on
patch([Cat;flip(Cat)],[repmat(quantile(OffTimeAll,0.25)*TimeRes/60,2,1);repmat(quantile(OffTimeAll,0.75)*TimeRes/60,2,1)],'red','EdgeColor','none','FaceAlpha',FaceAlpha); hold on
plot(Cat,repmat(nanmedian(OffTimeAll)*TimeRes/60,2,1),'-','DisplayName','mean','Color',[0.6980,0.0941,0.1686],'LineWidth',LineWidth)
%plot(Cat,repmat(quantile(OffTimeAll,0.25)*TimeRes/60,2,1),'-','DisplayName','Q1','Color',[0.6980,0.0941,0.1686,0.8],'LineWidth',LineWidth)
%plot(Cat,repmat(quantile(OffTimeAll,0.75)*TimeRes/60,2,1),'-','DisplayName','Q3','Color',[0.6980,0.0941,0.1686,0.8],'LineWidth',LineWidth)
%errorbar([1:1:length(Nicknames)],nanmean(OffTimeAll*TimeRes/60), nanstd(OffTimeAll*TimeRes/60)*0, nanstd(OffTimeAll*TimeRes/60),'Color',[0.6980,0.0941,0.1686,0.8],'LineStyle','none','LineWidth',0.5)
legend off
xticks([1:1:length(Nicknames)])
xticklabels(ExpLabels)
set(gca,'FontSize',FontSize)
%set(gca, 'YScale', 'log')
title('off time (min)','FontSize',FontSizeTitle); box off;xlim([0+Jitter,length(Nicknames)+Jitter]); 
%set(findobj(gca, 'type', 'line'), 'linew',2)

subplot(1,8,8); 
CatX = repmat([1:1:length(Nicknames)],length(BSizeAll),1);
h = gscatter(CatX(:)+(rand(length(CatX(:)),1)-0.5).*Jitter, BSizeAll(:), RepBSizeAll(:),CMAP,'.',DotSize);hold on
patch([Cat;flip(Cat)],[repmat(quantile(BSizeAll,0.25),2,1);repmat(quantile(BSizeAll,0.75),2,1)],'red','EdgeColor','none','FaceAlpha',FaceAlpha); hold on
plot(Cat,repmat(nanmedian(BSizeAll),2,1),'-','DisplayName','mean','Color',[0.6980,0.0941,0.1686],'LineWidth',LineWidth)
%plot(Cat,repmat(quantile(BSizeAll,0.25),2,1),'-','DisplayName','Q1','Color',[0.6980,0.0941,0.1686,0.8],'LineWidth',LineWidth)
%plot(Cat,repmat(quantile(BSizeAll,0.75),2,1),'-','DisplayName','Q3','Color',[0.6980,0.0941,0.1686,0.8],'LineWidth',LineWidth)
%errorbar([1:1:length(Nicknames)],nanmean(BSizeAll), nanstd(BSizeAll).*0, nanstd(BSizeAll),'Color',[0.6980,0.0941,0.1686,0.8],'LineStyle','none','LineWidth',0.5)
legend off
xticks([1:1:length(Nicknames)])
xticklabels(ExpLabels)
set(gca,'FontSize',FontSize)
%set(gca, 'YScale', 'log')
title('burst size (AU)','FontSize',FontSizeTitle); box off;xlim([0+Jitter,length(Nicknames)+Jitter]); 
%set(findobj(gca, 'type', 'line'), 'linew',2)

%export_fig FileOut -pdf
%saveas(Fig,FileOut,'pdf')
print(Fig,FileOut,'-fillpage','-dpdf');
%print(Fig,FileOut,'-dtiff');


%end
%%



%%
FileOut = [PathMain,'/comp_bursting_violin',cell2mat(join(unique(Selections),'_')),'_',cell2mat(join(ExpLabels,'_vs_')),'.pdf']
    %Fig = figure('PaperSize',[10*length(Nicknames) Height],'resize','off', 'visible','on','Units','points');
        Fig = figure('PaperUnits','inches','PaperSize',[3*length(Nicknames) 6],'Units','points','resize','on', 'visible','on','DefaultAxesFontSize', 4);
set(0,'defaultAxesFontSize',4)
      set(0, 'DefaultFigureRenderer', 'painters');
          set(gcf,'defaultLegendAutoUpdate','off')
          set(Fig,'defaultAxesColorOrder',Palette)

%   set(Fig,'defaultAxesFontSize',6)
 %     set(Fig, 'DefaultFigureRenderer', 'painters');

CMAP = bone(MaxCol+1);
CMAP = zeros(size(CMAP))+0.7;
CMAP(:,4) = FaceAlpha;
Cat = repmat([1:1:length(Nicknames)],2,1)+[-BarW./2;+BarW./2];

% % NUMBER CELLS ON
% subplot(2,5,1); 
% CatX = repmat([1:1:length(Nicknames)],size(NumOn,1),1);
% gscatter(CatX(:)+(rand(length(CatX(:)),1)-0.5).*Jitter, NumOn(:), RepNumOn(:),CMAP,'.',5); hold on
% patch([Cat;flip(Cat)],[repmat(quantile(NumOn,0.25),2,1);repmat(quantile(NumOn,0.75),2,1)],[1:length(Nicknames)]','EdgeColor','none','FaceAlpha',FaceAlpha); hold on
% plot(Cat,repmat(nanmean(NumOn),2,1),'-','DisplayName','mean','Color',[0.3,0.3,0.3],'LineWidth',LineWidth)
% %plot(Cat,repmat(quantile(NumOn,0.25)*100,2,1),'-','DisplayName','Q1','Color',[0.6980,0.0941,0.1686,0.8],'LineWidth',LineWidth)
% %plot(Cat,repmat(quantile(NumOn,0.75)*100,2,1),'-','DisplayName','Q3','Color',[0.6980,0.0941,0.1686,0.8],'LineWidth',LineWidth)
% errorbar([1:1:length(Nicknames)],nanmean(NumOn), nanstd(NumOn), nanstd(NumOn),'Color',[0.3,0.3,0.3,0.8],'LineStyle','none','LineWidth',0.5)
% legend off
% xticks([1:1:length(Nicknames)])
% xticklabels(ExpLabels)
% %set(findobj(gca, 'type', 'line'), 'linew',2)
% %set(findall(gca,'type','text'),'fontSize',4,'fontWeight','bold')
% set(gca,'FontSize',FontSize)
% title('# active cells','FontSize',FontSizeTitle); box off; 
%     xlim([BarW,length(Nicknames)+1-BarW])
% colormap(Palette)



% ONSET/ENDS
% subplot(2,5,1); 
% CatBoth = repmat([1:1:length(Nicknames)],2,1)+[-BarW./2;+BarW./2];
% CatX = repmat([1:1:length(Nicknames)],size(OnsetAll,1),1);
% gscatter(CatX(:)+(rand(length(CatX(:)),1)-0.5).*Jitter, OnsetAll(:), RepOnsetAll(:),CMAP,'.',5); hold on
% patch([CatBoth;flip(CatBoth)],[repmat(quantile(OnsetAll,0.25),2,1);repmat(quantile(OnsetAll,0.75),2,1)],[1:length(Nicknames)]','EdgeColor','none','FaceAlpha',FaceAlpha); hold on
% plot(CatBoth,repmat(nanmean(OnsetAll),2,1),'-','DisplayName','mean','Color',[0.3,0.3,0.3],'LineWidth',LineWidth)
% errorbar([1:1:length(Nicknames)],nanmean(OnsetAll), nanstd(OnsetAll), nanstd(OnsetAll),'Color',[0.3,0.3,0.3,0.8],'LineStyle','none','LineWidth',0.5)
% 
% gscatter(CatX(:)+(rand(length(CatX(:)),1)-0.5).*Jitter, EndAll(:), RepOnsetAll(:),CMAP,'.',5); hold on
% patch([CatBoth;flip(CatBoth)],[repmat(quantile(EndAll,0.25),2,1);repmat(quantile(EndAll,0.75),2,1)],[1:length(Nicknames)]','EdgeColor','none','FaceAlpha',FaceAlpha); hold on
% plot(CatBoth,repmat(nanmean(EndAll),2,1),'-','DisplayName','mean','Color',[0.3,0.3,0.3],'LineWidth',LineWidth)
% errorbar([1:1:length(Nicknames)],nanmean(EndAll), nanstd(EndAll), nanstd(EndAll),'Color',[0.3,0.3,0.3,0.8],'LineStyle','none','LineWidth',0.5)
% 
% colormap(Palette)
% legend off
%     xlim([BarW,length(Nicknames)+1-BarW])
% xticks([1:1:length(Nicknames)])
% xticklabels(ExpLabels)
% %set(findobj(gca, 'type', 'line'), 'linew',2)
% %set(findall(gca,'type','text'),'fontSize',4,'fontWeight','bold')
% set(gca,'FontSize',FontSize)
% title('% active cells','FontSize',FontSizeTitle); box off; 
% ylim([0,105]);
% xlim([0+Jitter,length(Nicknames)+Jitter]); 

% ONSET/ENDS VIOLIN
subplot(2,5,1); 
plotViolin(OnsetAll,RepOnsetAll,Nicknames,ExpLabels,2,Jitter,BarW,'onset/ends (min)',FontSize,DotSize,CMAP,0.2,LineWidth,FontSizeTitle,1,0)
plotViolin(EndAll,RepOnsetAll,Nicknames,ExpLabels,2,Jitter,BarW,'onset/ends (min)',FontSize,DotSize,CMAP,FaceAlpha,LineWidth,FontSizeTitle,1,0)


% PERC CELLS ON
subplot(2,5,2); 
CatX = repmat([1:1:length(Nicknames)],size(PercOn,1),1);
gscatter(CatX(:)+(rand(length(CatX(:)),1)-0.5).*Jitter, PercOn(:)*100, RepNumOn(:),CMAP,'.',5); hold on
patch([Cat;flip(Cat)],[repmat(quantile(PercOn*100,0.25),2,1);repmat(quantile(PercOn*100,0.75),2,1)],[1:length(Nicknames)]','EdgeColor','none','FaceAlpha',FaceAlpha); hold on
plot(Cat,repmat(nanmean(PercOn*100),2,1),'-','DisplayName','mean','Color',[0.3,0.3,0.3],'LineWidth',LineWidth)
%plot(Cat,repmat(quantile(NumOn,0.25)*100,2,1),'-','DisplayName','Q1','Color',[0.6980,0.0941,0.1686,0.8],'LineWidth',LineWidth)
%plot(Cat,repmat(quantile(NumOn,0.75)*100,2,1),'-','DisplayName','Q3','Color',[0.6980,0.0941,0.1686,0.8],'LineWidth',LineWidth)
errorbar([1:1:length(Nicknames)],nanmean(PercOn*100), nanstd(PercOn*100), nanstd(PercOn*100),'Color',[0.3,0.3,0.3,0.8],'LineStyle','none','LineWidth',0.5)
legend off
xticks([1:1:length(Nicknames)])
xticklabels(ExpLabels)
%set(findobj(gca, 'type', 'line'), 'linew',2)
%set(findall(gca,'type','text'),'fontSize',4,'fontWeight','bold')
set(gca,'FontSize',FontSize)
title('# active cells','FontSize',FontSizeTitle); box off; 
    xlim([BarW,length(Nicknames)+1-BarW])
colormap(Palette)


% PROPORTION SUSTAINED
subplot(2,5,3); 
CatBoth = repmat([1:1:length(Nicknames)],2,1)+[-BarW./2;+BarW./2];
CatX = repmat([1:1:length(Nicknames)],size(PercCont,1),1);
gscatter(CatX(:)+(rand(length(CatX(:)),1)-0.5).*Jitter, PercCont(:)*100, RepNumOn(:),CMAP,'.',5); hold on
patch([CatBoth;flip(CatBoth)],[repmat(quantile(PercCont,0.25)*100,2,1);repmat(quantile(PercCont,0.75)*100,2,1)],[1:length(Nicknames)]','EdgeColor','none','FaceAlpha',FaceAlpha); hold on
plot(CatBoth,repmat(nanmean(PercCont)*100,2,1),'-','DisplayName','mean','Color',[0.3,0.3,0.3],'LineWidth',LineWidth)
%plot(Cat,repmat(quantile(NumOn,0.25)*100,2,1),'-','DisplayName','Q1','Color',[0.6980,0.0941,0.1686,0.8],'LineWidth',LineWidth)
%plot(Cat,repmat(quantile(NumOn,0.75)*100,2,1),'-','DisplayName','Q3','Color',[0.6980,0.0941,0.1686,0.8],'LineWidth',LineWidth)
errorbar([1:1:length(Nicknames)],nanmean(PercCont)*100, nanstd(PercCont)*100, nanstd(PercCont)*100,'Color',[0.3,0.3,0.3,0.8],'LineStyle','none','LineWidth',0.5)
colormap(Palette)
legend off
    xlim([BarW,length(Nicknames)+1-BarW])
xticks([1:1:length(Nicknames)])
xticklabels(ExpLabels)
%set(findobj(gca, 'type', 'line'), 'linew',2)
%set(findall(gca,'type','text'),'fontSize',4,'fontWeight','bold')
set(gca,'FontSize',FontSize)
title('% sustained profile','FontSize',FontSizeTitle); box off; 
ylim([0,105]);
%xlim([0+Jitter,length(Nicknames)+Jitter]); 

% NUMBER OF BURSTS
subplot(2,5,4); 
plotViolin(BNumAll,RepOnsetAll,Nicknames,ExpLabels,1,Jitter,BarW,'bursts # / cell',FontSize,DotSize,CMAP,FaceAlpha,LineWidth,FontSizeTitle,1,0)

% CatX = repmat([1:1:length(Nicknames)],length(BNumAll),1);
% h = gscatter(CatX(:)+(rand(length(CatX(:)),1)-0.5).*Jitter, BNumAll(:), RepBNumAll(:),CMAP,'.',DotSize);hold on
% patch([CatBoth;flip(CatBoth)],[repmat(quantile(BNumAll,0.25),2,1);repmat(quantile(BNumAll,0.75),2,1)],[1:length(Nicknames)]','EdgeColor','none','FaceAlpha',FaceAlpha); hold on
% plot(CatBoth,repmat(nanmean(BNumAll),2,1),'-','DisplayName','mean','Color',[0.3,0.3,0.3],'LineWidth',LineWidth)
% %plot(Cat,repmat(quantile(BNumAll,0.25),2,1),'-','DisplayName','Q1','Color',[0.6980,0.0941,0.1686,0.8],'LineWidth',LineWidth)
% %plot(Cat,repmat(quantile(BNumAll,0.75),2,1),'-','DisplayName','Q3','Color',[0.6980,0.0941,0.1686,0.8],'LineWidth',LineWidth)
% colormap(Palette)
% errorbar([1:1:length(Nicknames)],nanmean(BNumAll), nanstd(BNumAll), nanstd(BNumAll),'Color',[0.3,0.3,0.3,0.8],'LineStyle','none','LineWidth',0.5)
% legend off
%     xlim([BarW,length(Nicknames)+1-BarW])
% xticks([1:1:length(Nicknames)])
% xticklabels(ExpLabels)
% set(gca,'FontSize',FontSize)
% title('# bursts per cell','FontSize',FontSizeTitle); 
% box off;
%xlim([1-Jitter,length(Nicknames)+Jitter]); 
%set(findobjgca, 'type', 'line'), 'linew',2)

% ONSET/ENDS VIOLIN
subplot(2,5,5); 
plotViolin(TmAll,RepOnsetAll,Nicknames,ExpLabels,100,Jitter,BarW,'total mRNA (AU)',FontSize,DotSize,CMAP,FaceAlpha,LineWidth,FontSizeTitle,1,0)


Log = 1;

% AMPLITUDE
subplot(2,5,6); 
plotViolin(BAmpAll,RepBAmpAll,Nicknames,ExpLabels,100,Jitter,BarW,'burst amplitude (AU)',FontSize,DotSize,CMAP,FaceAlpha,LineWidth,FontSizeTitle,100,Log)

% TIME OFF
subplot(2,5,7); 
plotViolin(OffTimeAll.*TimeRes./60,RepOffTimeAll,Nicknames,ExpLabels,0.5,Jitter,BarW,'off time (min)',FontSize,DotSize,CMAP,FaceAlpha,LineWidth,FontSizeTitle,1,Log)

% LENGTH
subplot(2,5,8); 
plotViolin(BLenAll.*TimeRes./60,RepBLenAll,Nicknames,ExpLabels,0.5,Jitter,BarW,'burst length (min)',FontSize,DotSize,CMAP,FaceAlpha,LineWidth,FontSizeTitle,1,Log)

% PERIOD
subplot(2,5,9); 
plotViolin(BPerAll.*TimeRes./60,RepBPerAll,Nicknames,ExpLabels,0.5,Jitter,BarW,'burst period (min)',FontSize,DotSize,CMAP,FaceAlpha,LineWidth,FontSizeTitle,1,Log)

% SIZE
subplot(2,5,10); 
plotViolin(BSizeAll,RepBSizeAll,Nicknames,ExpLabels,100,Jitter,BarW,'burst size (AU)',FontSize,DotSize,CMAP,FaceAlpha,LineWidth,FontSizeTitle,1,Log)


%export_fig FileOut -pdf
%saveas(Fig,FileOut,'pdf')
print(Fig,FileOut,'-fillpage','-dpdf');
%print(Fig,FileOut,'-dtiff');
close all
%end

%%
% a test decision for the null hypothesis that the data in vectors x and y
% comes from independent random samples from normal distributions with
% equal means and equal but unknown variances, using the two-sample t-test.
% The alternative hypothesis is that the data in x and y comes from
% populations with unequal means. The result h is 1 if the test rejects the
% null hypothesis at the 5% significance level, and 0 otherwise
% 1 if coming from different normal distributions
%[h,p,ci,stats] = ttest2(BAmpAll(:,1),BAmpAll(:,2),'Vartype','unequal'); disp(h);p
%[h,p,ci,stats] = ttest2(BAmpAll(:,2),BAmpAll(:,3),'Vartype','unequal'); disp(h);p


% a test decision for the null hypothesis that the data in vector x comes
% from a distribution in the normal family, against the alternative that it
% does not come from such a distribution, using a Lilliefors test.
% 1 if not normally distributed
% lillietest(BAmpAll(:,1))
% lillietest(BAmpAll(:,2))
% lillietest(BAmpAll(:,3))


%a test decision for the null hypothesis that the data in vectors x1 and x2
%are from the same continuous distribution, using the two-sample
%Kolmogorov-Smirnov test. The alternative hypothesis is that x1 and x2 are
%from different continuous distributions. The result h is 1 if the test
%rejects the null hypothesis at the 5% significance level, and 0 otherwise
fileID = fopen([PathMain,'/comp_bursting_violin',cell2mat(join(unique(Selections),'_')),'_',cell2mat(join(ExpLabels,'_vs_')),'_ks.txt'],'a');
fprintf(fileID, '\nupdated on \t%s\n',date);
[h,p,ks2stat] = kstest2(BAmpAll(:,1),BAmpAll(:,2));
fprintf(fileID, 'amp12\t%E\t%s\n',p,asterisk(p));
[h,p,ks2stat] = kstest2(OffTimeAll(:,1),OffTimeAll(:,2));
fprintf(fileID, 'off12\t%E\t%s\n',p,asterisk(p));
[h,p,ks2stat] = kstest2(BLenAll(:,1),BLenAll(:,2));
fprintf(fileID, 'length12\t%E\t%s\n',p,asterisk(p));
[h,p,ks2stat] = kstest2(BSizeAll(:,1),BSizeAll(:,2));
fprintf(fileID, 'size12\t%E\t%s\n',p,asterisk(p));
if length(Nicknames) == 3
    [h,p,ks2stat] = kstest2(BAmpAll(:,2),BAmpAll(:,3));
    fprintf(fileID, 'amp23\t%E\t%s\n',p,asterisk(p));
    [h,p,ks2stat] = kstest2(OffTimeAll(:,2),OffTimeAll(:,3));
    fprintf(fileID, 'off23\t%E\t%s\n',p,asterisk(p));
    [h,p,ks2stat] = kstest2(BLenAll(:,2),BLenAll(:,3));
    fprintf(fileID, 'length23\t%E\t%s\n',p,asterisk(p));
    [h,p,ks2stat] = kstest2(BSizeAll(:,2),BSizeAll(:,3));
    fprintf(fileID, 'size23\t%E\t%s\n',p,asterisk(p));
    [h,p,ks2stat] = kstest2(BAmpAll(:,1),BAmpAll(:,3));
    fprintf(fileID, 'amp13\t%E\t%s\n',p,asterisk(p));
    [h,p,ks2stat] = kstest2(OffTimeAll(:,1),OffTimeAll(:,3));
    fprintf(fileID, 'off13\t%E\t%s\n',p,asterisk(p));
    [h,p,ks2stat] = kstest2(BLenAll(:,1),BLenAll(:,3));
    fprintf(fileID, 'length13\t%E\t%s\n',p,asterisk(p));
    [h,p,ks2stat] = kstest2(BSizeAll(:,1),BSizeAll(:,3));
    fprintf(fileID, 'size13\t%E\t%s\n',p,asterisk(p));
end
if length(Nicknames) == 4
    [h,p,ks2stat] = kstest2(BAmpAll(:,3),BAmpAll(:,4));
    fprintf(fileID, 'amp34\t%E\t%s\n',p,asterisk(p));
    [h,p,ks2stat] = kstest2(OffTimeAll(:,3),OffTimeAll(:,4));
    fprintf(fileID, 'off34\t%E\t%s\n',p,asterisk(p));
    [h,p,ks2stat] = kstest2(BLenAll(:,3),BLenAll(:,4));
    fprintf(fileID, 'length34\t%E\t%s\n',p,asterisk(p));
    [h,p,ks2stat] = kstest2(BSizeAll(:,3),BSizeAll(:,4));
    fprintf(fileID, 'size34\t%E\t%s\n',p,asterisk(p));
end

fclose(fileID);
end
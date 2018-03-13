clear
fileFolder=fullfile('..\test\');
dirOutput=dir(fullfile(fileFolder,'*'));
filenames={dirOutput.name};
filenames(:,1)=[];
filenames(:,1)=[];
filebytes={dirOutput.bytes};
filebytes(:,1)=[];
filebytes(:,1)=[];
filebytes=cell2mat(filebytes);
for i=1:length(filenames)-1;
    for j=1:length(filenames)-i;
    if filebytes(j)>filebytes(j+1);
        temp=filebytes(j+1);
        filebytes(j+1)=filebytes(j);
        filebytes(j)=temp; 
        temp=filenames(j+1);
        filenames(j+1)=filenames(j);
        filenames(j)=temp;

    end
    end
end

filenames=filenames';

FinalResults=-1*ones(1,length(filenames));
RunTimes=-inf*ones(1,length(filenames));
tasktimes=-inf*ones(1,length(filenames));
outFile=fopen('ResultFil1s.txt','a+');
for i0=1:length(filenames)
filename=strcat('..\test\',filenames{i0});
filename2=strcat('..\result\',filenames{i0});
% % %% for 3SAT uniform instances
%  original_data= importdata(filename);
% % % %filename='n3k8SATNoHeader.txt'
% original_data = original_data.textdata(9:end-1,1:end);%去掉无用信息
% [m,n] = size(original_data);
% data = zeros(m,n);
% for i4 = 1 :m*n
%     data(i4) = str2double(original_data{i4});%cell数据类型转为方便处理的double类型
% end
fid=fopen(filename);
if (fid~=-1)
%data = dlmread(filename,'',3,0);%app16文件夹下文件的读�?读取原妾sat文件的数值部�?9/29/2017,this has bug
%data = dlmread(filename,'',0,0);%3SAT random文件夹下文件的读�?读取原妾sat文件的数值部�?
tline=fgetl(fid);
for i = 1 : 100
    if tline(1) == 'p'
        target = i;
        break
    end
    tline=fgetl(fid);
end
C=textscan(tline,'%s ');
C=C{1};
kk = str2num(cell2mat(C(4)));%子句个数
nn = str2num(cell2mat(C(3)));%变量个数a
n=nn
k=kk

%% generating ILP constraints from CNF literals
fid2 = fopen('mylp.lp','wt');%写入文件路径
fprintf(fid2, '\\ Model matlab\n');
fprintf(fid2, '\\ LP format - for model browsing. Use MPS format to capture full model detail.\n');
fprintf(fid2, 'Minimize\n ');
for ii=1:n
mini=strcat('C',num2str(ii-1));
if (mod(ii,10)==0)
mini=strcat(mini,'\n ');
end
if (ii~=n)
mini=strcat(mini,' +');
end
mini=[mini,' '];
fprintf(fid2,mini);
end
fprintf(fid2, '\nSubject To\n');
for i4=1:k
    tline=fgetl(fid);
    C=textscan(tline,'%s ');
    C=C{1};
    temp1=ones(size(C));
    for i7=1:size(C)
      temp1(i7)=str2num(cell2mat(C(i7)));   
    end
    temp3=strcat('R',num2str(i4-1));
    count=0;
    len=length(find(temp1~=0));
    if len>0
        for j=1:len,
            
            temp2=temp1(j);
            if(temp2>0) 
                  if (j==1)
                  temp3=strcat(temp3,': C ');
                  else 
                  temp3=strcat(temp3,' + C');
                   end 
                temp3=strcat(temp3,num2str(abs(temp2)-1));
             
            else
			    if (j==1)
				temp3=strcat(temp3,': -C ');
				else 
                temp3=strcat(temp3,' - C');
                end 
                temp3=strcat(temp3,num2str(abs(temp2)-1));
				
                count=count+1;
            end
            %temp3=strcat(temp3,'+');
            
        end
    end
    %temp3
	value=1-count;
    temp3=strcat(temp3,' >=');
    fprintf(fid2,' ');
    temp3=[temp3,' ',num2str(value)];
	fprintf(fid2,temp3);
	fprintf(fid2,'\n');
end
fprintf(fid2,'\nBinaries\n');    
for ii=1:n
mini=strcat(' C',num2str(ii-1));
if (mod(ii,10)==0)
mini=strcat(mini,'\n ');
end
fprintf(fid2,mini);
end 
fprintf(fid2,'\nEnd\n'); 


else 
    disp('file cannot open?');
end
% if (SAT==1)
% FinalResults(i0)=1;
% else
%   FinalResults(i0)=0;  
% end
 fclose(fid); 
 fclose(fid2);
 fprintf ( 1, 'lp file ok\n' );
file1=strcat(filename2,int2str(i));
file1=strcat(file1,'.txt');
startTime=tic;
resultstatus=find_oneNew();
 RunTimes(i0)=toc(startTime);
%
%  Submit the job.
%
  
  FindTaskFinished=0;   
      if exist('C0.txt', 'file')  % Find one task completed & isempty(completed(1).Error)
        FindTaskFinished=1;
        fprintf ( 1, 'find one SAT, break...' );
          FinalResults(i0)=1;
      else
          if (~exist('C0.txt', 'file'))
           FindTaskFinished=1;
            FinalResults(i0)=0;
           fprintf ( 1, 'finished all and UNSAT, destroy...' );
           end
      end
 fprintf(outFile, '%s %f  %f  %s \n',filename, FinalResults(i0),RunTimes(i0),resultstatus);
if (exist('C0.txt', 'file'))
movefile('C0.txt',file1);
end

end
function resultstatus = find_oneNew()
    model = gurobi_read('mylp.lp');
    clear params;
    params.outputflag = 1;
    %params.resultfile = 'mylp.lp';
    %params.MIPFocus=1;
    params.TimeLimit=5000;
    params.SolutionLimit=1;
    params.ConcurrentMIP=24;
    result = gurobi(model, params);
    resultstatus=result.status;
    if isfield(result,'x')&&~exist('C0.txt', 'file')
    fid = fopen('C0.txt','a+');%写入文件路径
        fprintf(fid, '%g\t', int8(result.x));
        fclose(fid); 
    end
end
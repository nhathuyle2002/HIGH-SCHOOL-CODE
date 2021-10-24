const   ginp='bai1.inp';
        gout='bai1.out';
        maxn=2642287-1;

var     k,cou:longint;
        mn,res:qword;
        a:array[0..maxn] of qword;

procedure enter;
var     i,j:longint;
        d:array[0..maxn] of boolean;
begin
        fillchar(d,sizeof(d),true);
        cou:=0;
        for i:=2 to maxn do
                if d[i] then
                begin
                        inc(cou);a[cou]:=i;
                        for j:=i to maxn div i do d[i*j]:=false;
                end;
end;

procedure process;
var     i:longint;
begin
        read(mn,k);
        res:=1;
        for i:=1 to k do res:=res*a[i];
        if res>mn then write(-1) else
        begin
                for i:=k+1 to cou do
                begin
                        if res div a[i-k]>mn div a[i] then break;
                        res:=res div a[i-k]*a[i];
                end;
                write(res);
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.

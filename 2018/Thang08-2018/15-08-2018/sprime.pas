const   ginp='sprime.inp';
        gout='sprime.out';
        maxn=3000000;

var     st:longint;
        d:array[0..maxn] of longint;

procedure create;
var     i,j,tmp,sum:longint;
        nt:array[0..maxn] of boolean;
begin
        fillchar(nt,sizeof(nt),true);
        for i:=2 to maxn do
                if nt[i] then
                        for j:=i to maxn div i do nt[i*j]:=false;
        for i:=2 to maxn do
        begin
                d[i]:=d[i-1];
                if not nt[i] then continue;
                sum:=0;tmp:=i;
                while tmp>0 do
                begin
                        sum:=sum+tmp mod 10;
                        tmp:=tmp div 10;
                end;
                if sum mod 5=0 then inc(d[i]);
        end;
end;

procedure process;
var     i,l,r:longint;
begin
        readln(st);
        for i:=1 to st do
        begin
                readln(l,r);
                writeln(d[r]-d[l-1]);
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        create;
        process;
        close(input);close(output);
end.

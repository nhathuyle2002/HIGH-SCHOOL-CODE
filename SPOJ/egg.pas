const   ginp='ss.inp';
        gout='ss.out';
        maxe=10;
        maxn=1000;

var     e,n,st:longint;
        d:array[0..1000,0..1000] of longint;

procedure create;
var     i,j:longint;
begin
        for i:=1 to maxn do
                for j:=1 to maxe do
                begin
                        d[i,j]:=d[i-1,j]+d[i-1,j-1]+1;
                        if d[i,j]>maxn then d[i,j]:=maxn+100;
                end;
end;

procedure process;
var     i,k:longint;
begin
        readln(st);
        for k:=1 to st do
        begin
                readln(e,n);
                if e>maxe then e:=maxe;
                for i:=1 to maxn do
                        if d[i,e]>=n then
                        begin
                                writeln(i);
                                break;
                        end;
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        create;
        process;
        close(input);close(output);
end.

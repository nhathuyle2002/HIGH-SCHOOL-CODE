const   ginp='ss.inp';
        gout='ss.out';
        maxn=trunc(sqrt(1000000001));

var     n,st:longint;
        a:array[0..maxn] of longint;

procedure create;
var     i,j:longint;
        d:array[0..maxn] of boolean;
begin
        fillchar(d,sizeof(d),true);
        for i:=2 to maxn do
                if d[i] then
                begin
                        inc(n);a[n]:=i;
                        for j:=i to maxn div i do d[i*j]:=false;
                end;
end;

procedure process;
var     i,x,u,v,tu,tv,cou:longint;
begin
        readln(x);
        u:=1;v:=1;
        for i:=1 to n do
                if a[i]>sqrt(x) then break else
                begin
                        cou:=0;
                        tu:=1;tv:=1;
                        while x mod a[i]=0 do
                        begin
                                inc(cou);
                                if cou mod 2=0 then
                                begin
                                        tu:=tu*a[i];
                                        tv:=1;
                                end else tv:=a[i];
                                x:=x div a[i];
                        end;
                        u:=u*tu;v:=v*tv;
                end;
        v:=v*x;
        writeln(u,' ',v);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        create;
        readln(st);
        while st>0 do
        begin
                process;
                dec(st);
        end;
        close(input);close(output);
end.

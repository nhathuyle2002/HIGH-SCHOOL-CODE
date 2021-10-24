const   ginp='ss.inp';
        gout='ss.out';

var     m,n,k,res:longint;
        a:array[0..101] of string[101];
        d:array[0..101,0..101,'A'..'Z'] of longint;

procedure enter;
var     i,j:longint;
        x:char;
begin
        readln(m,n,k);
        for i:=1 to m do
        begin
                readln(a[i]);
                for j:=1 to n do
                        for x:='A' to 'Z' do
                        begin
                                d[i,j,x]:=d[i-1,j,x]+d[i,j-1,x]-d[i-1,j-1,x];
                                if x=a[i,j] then inc(d[i,j,x]);
                        end;
        end;
end;

function calc(i0,i,j0,j:longint):longint;
var     x:char;
begin
        calc:=0;
        for x:='A' to 'Z' do
                if d[i,j,x]-d[i0-1,j,x]-d[i,j0-1,x]+d[i0-1,j0-1,x]>0 then inc(calc);
end;

procedure process;
var     i1,i2,i,j,j1,j2,tmp:longint;
        ok:boolean;
begin
        res:=0;
        for i1:=1 to m do
        for i2:=m downto i1 do
        begin
                j1:=1;j2:=1;
                ok:=false;
                for j:=1 to n do
                begin
                        while (j1<=n) do
                        begin
                                tmp:=calc(i1,i2,j,j1);
                                if tmp<k then inc(j1) else break;
                        end;
                        while (j2<=n) and (calc(i1,i2,j,j2)<=k) do inc(j2);
                        if j1=n+1 then break;
                        if tmp=k then res:=res+j2-j1;
                        if tmp>=k then ok:=true;
                end;
                if not ok then break;
        end;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.

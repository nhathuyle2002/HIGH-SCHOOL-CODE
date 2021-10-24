const   ginp='machine.inp';
        gout='machine.out';
        maxt=3000000;

var     n,res:longint;
        a,b:array[0..maxt+1] of longint;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

procedure enter;
var     i,u,v:longint;
begin
        readln(n);
        for i:=1 to n do
        begin
                readln(u,v);
                a[v]:=max(a[v],v-u);
                b[u]:=max(b[u],v-u);
        end;
end;

procedure process;
var     i:longint;
begin
        for i:=1 to maxt do a[i]:=max(a[i],a[i-1]);
        for i:=maxt downto 1 do b[i]:=max(b[i],b[i+1]);
        res:=-1;
        for i:=2 to maxt do
                if (a[i-1]>0) and (b[i]>0) then res:=max(res,a[i-1]+b[i]);
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.

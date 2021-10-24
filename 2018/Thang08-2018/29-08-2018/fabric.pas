const   ginp='fabric.inp';
        gout='fabric.out';
        oo=trunc(1e5);

var     m,n,k:longint;
        res:int64;
        a:array[0..2010,0..2010] of longint;
        h:array[0..2010] of longint;

procedure enter;
var     i,j:longint;
begin
        readln(m,n,k);
        for i:=1 to m do
        begin
                for j:=1 to n do read(a[i,j]);
                readln;
        end;
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure process;
var     i,j,jj,minh,hh:longint;
begin
        res:=0;
        for i:=1 to m do
        begin
                for j:=1 to n do
                        if a[i,j]=0 then inc(h[j]) else h[j]:=0;
                for j:=1 to n do
                begin
                        minh:=oo;
                        for jj:=j to n do
                        begin
                                minh:=min(minh,h[jj]);
                                if minh=0 then break;
                                hh:=k div (jj-j+1);
                                if k mod (jj-j+1)>0 then inc(hh);
                                if minh>=hh then res:=res+minh-hh+1;
                        end;
                end;
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

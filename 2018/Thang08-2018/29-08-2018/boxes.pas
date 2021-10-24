const   ginp='boxes.inp';
        gout='boxes.out';
        oo=trunc(1e7);
        maxch=1 shl 20-1;

var     n,k,mch,res:longint;
        a:array[0..21,0..21] of longint;
        g:array[0..21,0..maxch] of longint;
        f:array[0..maxch] of longint;

procedure enter;
var     i,j:longint;
begin
        readln(n,k);
        for i:=1 to n do
        begin
                for j:=1 to n do read(a[i,j]);
                readln;
        end;
        mch:=1 shl n-1;
end;

function getb(x,i:longint):longint;
begin
        getb:=x shr (i-1) and 1;
end;

function setb(x,i,t:longint):longint;
begin
        if t=1 then setb:=x or (1 shl (i-1))
        else setb:=x and (not (1 shl (i-1)));
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure process;
var     x,i,i0,xx,cou:longint;
begin
        for x:=mch-1 downto 0 do
        begin
                for i0:=n downto 1 do
                        if getb(x,i0)=0 then break;
                for i:=1 to n do
                begin
                        g[i,x]:=oo;
                        if getb(x,i)=0 then
                        begin
                                if i<>i0 then g[i,x]:=min(a[i,i0],g[i,setb(x,i0,1)]);
                                i0:=i;
                        end;
                end;
        end;
        res:=oo;
        for x:=1 to mch-1 do
        begin
                cou:=0;f[x]:=oo;
                for i:=1 to n do
                        if getb(x,i)=1 then
                        begin
                                xx:=setb(x,i,0);
                                f[x]:=min(f[x],f[xx]+g[i,xx]);
                        end else inc(cou);
                if cou=k then res:=min(res,f[x]);
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

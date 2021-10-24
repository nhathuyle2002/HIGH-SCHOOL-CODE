const   ginp='water.inp';
        gout='water.out';
        maxch=1 shl 20-1;
        oo=trunc(1e9);

var     k,n,res,m,mch:longint;
        c:array[0..21,0..21] of longint;
        g:array[0..21,0..maxch] of longint;
        f:array[0..maxch] of longint;

procedure enter;
var     i,j:longint;
begin
        readln(n,k);
        for i:=1 to n do
        begin
                for j:=1 to n do read(c[i,j]);
                readln;
        end;
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

function getb(i,x:longint):longint;
begin
        getb:=x shr (i-1) and 1;
end;

function setb(i,x,tt:longint):longint;
begin
        if tt=1 then setb:=x or (1 shl (i-1))
        else setb:=x and (not (1 shl (i-1)));
end;

procedure process;
var     ch,i,cht,cou,i0:longint;
begin
        mch:=1 shl n-1;
        if k=n then res:=0 else res:=oo;
        for ch:=1 to mch do
        begin
                for i:=1 to n do
                        if getb(i,ch)=1 then i0:=i;
                for i:=1 to n do
                        if (getb(i,ch)=1) and (i=i0) then g[i,ch]:=oo else
                        if getb(i,ch)=1 then
                        begin
                                cht:=setb(i0,ch,0);
                                g[i,ch]:=min(g[i,cht],c[i,i0]);
                                i0:=i;
                        end;
        end;
        for ch:=mch-1 downto 1 do
        begin
                cou:=0;f[ch]:=oo;
                for i:=1 to n do
                        if getb(i,ch)=0 then
                        begin
                                cht:=setb(i,ch,1);
                                f[ch]:=min(f[ch],f[cht]+g[i,cht]);
                        end
                        else    inc(cou);
                if cou=k then res:=min(res,f[ch]);
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

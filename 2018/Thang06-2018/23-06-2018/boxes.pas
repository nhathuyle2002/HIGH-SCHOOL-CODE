const   ginp='boxes.inp';
        gout='boxes.out';
        oo=trunc(1e7);

var     gi,go:text;
        n,k,maxb,res:longint;
        c:array[0..21,0..21] of longint;
        f:array[0..1 shl 20-1] of longint;

procedure input;
var     i,j:longint;
begin
        readln(gi,n,k);
        for i:=1 to n do
        begin
                for j:=1 to n do read(gi,c[i,j]);
                readln(gi);
        end;
end;

function getb(i,x:longint):longint;
begin
        getb:=(x shr (i-1)) and 1;
end;

function setb(i,x,t:longint):longint;
begin
        if t=1 then setb:=x or (1 shl (i-1))
        else x:=x and (not (1 shl(i-1)));
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure process;
var     i,j,cou,ij,tm:longint;
begin
        res:=oo;
        maxb:=1 shl n-1;
        f[maxb]:=0;
        if k=n then res:=0;
        for i:=maxb-1 downto 1 do
        begin
                cou:=0;
                f[i]:=oo;
                for j:=1 to n do
                        if getb(j,i)=1 then inc(cou) else
                        begin
                                tm:=setb(j,i,1);
                                for ij:=1 to n do
                                        if getb(ij,i)=1 then f[i]:=min(f[i],f[tm]+c[j,ij]);
                        end;
                if cou=k then res:=min(res,f[i]);
        end;
        write(go,res);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
const   ginp='cwords.inp';
        gout='cwords.out';

var     gi,go:text;
        m:longint;
        res:int64;
        d:array[1..26,1..26] of longint;

function ma(x:char):longint;
begin
        exit(ord(x)-64);
end;

procedure input;
var     i:longint;
        s:string[10];
begin
        readln(gi,m);
        for i:=1 to m do
        begin
                readln(gi,s);
                inc(d[ma(s[1]),ma(s[length(s)])]);
        end;
end;

procedure process;
var     i,j,k,t,sll:longint;
        tm:int64;
        c:array[1..26,1..26] of longint;
        dd:array[1..26,1..26,1..26,1..26] of boolean;
begin
        fillchar(dd,sizeof(dd),true);
        fillchar(c,sizeof(c),0);
        res:=0;
        for i:=1 to 26 do
        for j:=1 to 26 do
        for k:=1 to 26 do
        for t:=1 to 26 do
                if dd[i,j,k,t] then
                begin
                        tm:=1;
                        inc(c[i,j]);inc(c[i,k]);inc(c[j,t]);inc(c[k,t]);
                        for sll:=c[i,j] downto 1 do
                                tm:=tm*(d[i,j]-sll+1);c[i,j]:=0;
                        for sll:=c[i,k] downto 1 do
                                tm:=tm*(d[i,k]-sll+1);c[i,k]:=0;
                        for sll:=c[j,t] downto 1 do
                                tm:=tm*(d[j,t]-sll+1);c[j,t]:=0;
                        for sll:=c[k,t] downto 1 do
                                tm:=tm*(d[k,t]-sll+1);c[k,t]:=0;
                        res:=res+tm;
                        dd[i,j,k,t]:=false;
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







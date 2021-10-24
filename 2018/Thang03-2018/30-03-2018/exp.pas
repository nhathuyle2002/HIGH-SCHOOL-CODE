const   ginp='exp.inp';
        gout='exp.out';

var     gi,go:text;
        n,dem:longint;
        s,ss:string;
        luu:array[0..101] of string;
        d:array[0..101] of boolean;

function cong(x,y:string):string;
var     i,nho,sum:longint;
begin
        nho:=0;cong:='';
        while length(x)<length(y) do x:='0'+x;
        while length(y)<length(x) do y:='0'+y;
        for i:=length(x) downto 1 do
        begin
                sum:=nho+ord(x[i])+ord(y[i])-96;
                nho:=sum div 10;
                cong:=chr(sum mod 10+48)+cong;
        end;
        if nho=1 then cong:='1'+cong;
end;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,s);
        while s[1]=' ' do delete(s,1,1);
        while s[length(s)]=' ' do delete(s,length(s),1);
        read(gi,ss);
        while ss[1]=' ' do delete(ss,1,1);
        while ss[length(ss)]=' ' do delete(ss,length(ss),1);
end;

procedure output;
var     i:longint;
begin
        for i:=dem downto 2 do
                write(go,luu[i],'+');
        write(go,luu[1]);
        close(gi);close(go);
        halt;
end;

function sosanh(x,y:string):boolean;
var     i:longint;
begin
        if length(x)>length(y) then exit(false);
        if length(y)>length(x) then exit(true);
        for i:=1 to length(x) do
                if (x[i]<y[i]) then exit(true)
                else if (y[i]<x[i]) then exit(false);
        exit(false);
end;

procedure try(i:longint;res:string);
var     j:longint;
        tm:string;
begin
        if i=0 then
        begin
                if res=ss then output;
                exit;
        end;
        tm:=cong(res,copy(s,1,i));
        if sosanh(tm,ss) then exit;
        inc(dem);
        for j:=i downto 1 do
        begin
                luu[dem]:=copy(s,j,i-j+1);
                try(j-1,cong(res,luu[dem]));
        end;
        dec(dem);
end;

begin
        input;
        dem:=0;
        try(length(s),'0');
end.













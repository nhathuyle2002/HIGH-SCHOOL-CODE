const
        fi='qua.inp';
        fo='qua.out';
var
        l:array[0..1000] of integer;
        a1,a2:array[0..501] of integer;
        tt:array[0..1000] of longint;
        n1,n2:integer;
        max:integer;
        t:longint;

procedure doc;
var
        f:text;
        i:integer;
begin
        assign(f,fi);  reset(f);
        read(f,t);
        read(f,n1);
        for i:=1 to n1 do read(f,a1[i]);
        read(f,n2);
        for i:=1 to n2 do read(f,a2[i]);
        close(f);
end;

procedure ghi;
var
        f:text;
begin
        assign(f,fo);  rewrite(f);
        writeln(f,max);
        close(f);
end;

procedure init;
var
        i,j:integer;
begin
        fillchar(l,sizeof(l),0);
        for i:=1 to n1 do
                for j:=0 to t do
                        if a1[i]+j<=t then
                        if l[a1[i]+j]=0 then l[a1[i]+j]:=i;
        tt[0]:=0;
        for i:=1 to n1 do
        tt[i]:=tt[i-1]+a1[i];
end;

function sohang(x:integer):integer;
var
        i,j,y:integer;dem:integer;
begin
        sohang:=0;
        for i:=n1 downto 0 do
                if tt[i]<=x+t then break;
        if i=0 then exit;
        for j:=x downto 0 do
                if l[j]<=i then
                begin
                        y:=tt[i]-j;
                        dem:=i;
                        while  y>t do
                        begin
                                y:=y-a1[i];
                                dec(dem);
                        end;
                        sohang:=dem;
                        exit;
                end;
end;

procedure xuli;
var
        i:integer;
        x,mm:longint;
begin
        init;
        x:=0;  max:=0;
        for i:=1 to n2 do
        begin
                x:=x+a2[i];
                if x>t then exit;
                mm:=i+sohang(t-x);
                if mm>max then max:=mm;
        end;

end;

begin
        doc;
        xuli;
        ghi;
end.

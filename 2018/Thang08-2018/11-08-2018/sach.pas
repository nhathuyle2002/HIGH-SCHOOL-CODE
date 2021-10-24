const   ginp='sach.inp';
        gout='sach.out';
        maxn=71;
        maxh=310;
        maxt=31;
        oo=trunc(1e6);

type    save=record h2,h3:longint;end;

var     n,res:longint;
        h,t,s:array[0..maxn] of longint;
        f:array[0..maxn*maxt,0..maxn*maxt] of save;

procedure enter;
var     i,j,tm:longint;
begin
        readln(n);
        for i:=1 to n do readln(h[i],t[i]);
        for i:=1 to n do
                for j:=i+1 to n do
                        if h[i]<h[j] then
                        begin
                                tm:=h[i];h[i]:=h[j];h[j]:=tm;
                        end;
        for i:=1 to n do s[i]:=s[i-1]+t[i];
end;

procedure getmin(var x,y:save);
begin
        if x.h2+x.h3>y.h2+y.h3 then x:=y;
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure process;
var     i,s1,s2,tam:longint;
        tmp:save;
begin
        for s1:=0 to s[n] do
                for s2:=0 to s[n] do
                begin
                        f[s1,s2].h2:=maxh;
                        f[s1,s2].h3:=maxh;
                end;
        for i:=1 to n-1 do
                for s1:=s[i] downto 0 do
                for s2:=s[i] downto 0 do
                begin
                        getmin(f[s1+t[i+1],s2],f[s1,s2]);
                        if s2<>0 then getmin(f[s1,t[i+1]+s2],f[s1,s2]);
                        if s2=0 then
                          begin
                                tmp:=f[s1,s2];
                                tmp.h2:=h[i+1];
                                getmin(f[s1,t[i+1]],tmp);
                          end;
                        if s[i]-s1-s2=0 then
                          begin
                                tmp:=f[s1,s2];
                                tmp.h3:=h[i+1];
                                getmin(f[s1,s2],tmp);
                          end;
                end;
        res:=oo;
        for s1:=1 to s[n] do
         for s2:=1 to s[n] do
           begin
            if s[n]-s1-s2<=0 then break;
            if (f[s1,s2].h2<>maxh)and(f[s1,s2].h3<>maxh) then
            begin
                tam:=max(s1,max(s2,s[n]-s1-s2));
                res:=min(res,tam*(h[1]+f[s1,s2].h2+f[s1,s2].h3));
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


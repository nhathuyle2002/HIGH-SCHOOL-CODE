uses math;
const
        fi='SACH.INP';
        fo='SACH.OUT';
        oo=trunc(1e12);
        max_h=333;
        max_n=77;
        max_t=33;
type    h_tu=record
                h2,h3:int64;
        end;
var
        f1,f2:text;
        h,t,x,sum:array[0..max_n] of longint;
        res,tam:int64;
        f:array[0..max_n*max_t,0..max_n*max_t] of h_tu;
        i,j,n,s1,s2:longint;
        tmp:h_tu;

procedure input;
begin
        readln(f1,n);
        for i:=1 to n do
          readln(f1,h[i],t[i]);
end;
procedure update;
var     max1,max2,max3,t1,t2,t3,dem1,dem2,dem3:longint;
begin
        max1:=0;t1:=0;dem1:=0;
        max2:=0;t2:=0;dem2:=0;
        max3:=0;t3:=0;dem3:=0;
        for i:=1 to n do
          begin
                if x[i]=1 then begin max1:=max(max1,h[i]); inc(t1,t[i]);inc(dem1); end;
                if x[i]=2 then begin max2:=max(max2,h[i]); inc(t2,t[i]);inc(dem2); end;
                if x[i]=3 then begin max3:=max(max3,h[i]); inc(t3,t[i]);inc(dem3); end;
          end;
        if (dem1=0)or(dem2=0)or(dem3=0) then exit;
        res:=min(res,(max1+max2+max3)*max(t1,max(t2,t3)));
end;
procedure try(i:longint);
var     j:longint;
begin
        for j:=1 to 3 do
          begin
                x[i]:=j;
                if i=n then update else try(i+1);
          end;
end;
procedure sub1;
begin
        res:=high(longint);
        try(1);
        writeln(f2,res);
end;
procedure qs(l,r: longint);
      var
         i,j,x,y: longint;
      begin
         i:=l;
         j:=r;
         x:=h[(l+r) div 2];
         repeat
           while h[i]>x do
            inc(i);
           while x>h[j] do
            dec(j);
           if not(i>j) then
             begin
                y:=h[i];
                h[i]:=h[j];
                h[j]:=y;
                y:=t[i];
                t[i]:=t[j];
                t[j]:=y;
                inc(i);
                j:=j-1;
             end;
         until i>j;
         if l<j then
           qs(l,j);
         if i<r then
           qs(i,r);
      end;
procedure getmin(var x,y:h_tu);
begin
        if x.h2+x.h3>y.h2+y.h3 then x:=y;
end;
procedure sub23;
begin
        qs(1,n);
        for s1:=0 to max_n*max_t do
        for s2:=0 to max_n*max_t do
        begin
        f[s1,s2].h2:=max_h;
        f[s1,s2].h3:=max_h;
        end;
        for i:=1 to n do sum[i]:=sum[i-1]+t[i];
        for i:=1 to n-1 do
          for s1:=sum[i] downto 0 do
             for s2:=sum[i]-s1 downto 0 do
                begin
                        getmin(f[s1+t[i+1],s2],f[s1,s2]);
                        if s2<>0 then getmin(f[s1,t[i+1]+s2],f[s1,s2]);
                        if s2=0 then
                          begin
                                tmp:=f[s1,s2];
                                tmp.h2:=h[i+1];
                                getmin(f[s1,t[i+1]],tmp);
                          end;
                        if sum[i]-s1-s2=0 then
                          begin
                                tmp:=f[s1,s2];
                                tmp.h3:=h[i+1];
                                getmin(f[s1,s2],tmp);
                          end;
                end;
        res:=oo;
        for s1:=1 to sum[n] do
         for s2:=1 to sum[n] do
           begin
            if sum[n]-s1-s2<=0 then break;
            if (f[s1,s2].h2<>max_h)and(f[s1,s2].h3<>max_h) then
            begin
                tam:=max(s1,max(s2,sum[n]-s1-s2));
                res:=min(res,tam*(h[1]+f[s1,s2].h2+f[s1,s2].h3));
            end;
           end;
        writeln(f2,res);
end;
begin
        assign(f1,fi);reset(f1);
        assign(f2,fo);rewrite(f2);
        input;
        //if n<=15 then sub1 else
        sub23;
        close(f1);
        close(f2);
end.

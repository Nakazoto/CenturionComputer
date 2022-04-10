
DEPDIR := .deps
DEPFLAGS = -MT $@ -MMD -MP -MF $(DEPDIR)/$*.d
OBJDIR := .objs


all: mon

SRCS = $(wildcard *.c)
OBJS = $(SRCS:%.c=$(OBJDIR)/%.o)

mon: $(OBJS)
	gcc -o $@ $^

# auto-dependency stuff

$(OBJDIR)/%.o : %.c
$(OBJDIR)/%.o: %.c $(DEPDIR)/%.d | $(DEPDIR) $(OBJDIR)
	gcc $(DEPFLAGS) -c -o $@ $<

DEPFILES := $(SRCS:%.c=$(DEPDIR)/%.d)
$(DEPFILES):

include $(wildcard $(DEPFILES))

$(DEPDIR):
	@mkdir -p $@

$(OBJDIR):
	@mkdir -p $@

.PHONY: clean
clean:
	rm -fr $(DEPDIR) $(OBJDIR) mon


